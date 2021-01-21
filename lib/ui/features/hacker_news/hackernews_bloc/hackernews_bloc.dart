import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/data/repository/hacker_news/news_repository.dart';
import 'package:meta/meta.dart';

import 'hackernews_event.dart';
import 'hackernews_state.dart';

class HackerBloc extends Bloc<HackerNewsEvent, HackerNewsState> {
  static const int INIT_PAGE_SIZE = 20;
  static const int PAGE_SIZE = 10;

  final _topStoryIds = List<int>();
  final _topStories = List<Story>();
  final _repository = NewsRepository();

  var _isLoadingMoreTopStories = false;
  var _currentStoryIndex = 0;

  StreamController<List<Story>> _topStoriesStreamController = StreamController();

  Stream<List<Story>> get topStories => _topStoriesStreamController.stream;

  NewsRepository repository;

  HackerBloc({@required this.repository}) : super(HackerNewsInitialState());

  @override
  // TODO: implement initialState
  HackerNewsState get initialState => HackerNewsInitialState();

  @override
  Stream<HackerNewsState> mapEventToState(HackerNewsEvent event) async* {
    if (event is FetchHackerNewsEvent) {
      yield* _loadInitTopStories();
    }
  }

  Stream<HackerNewsState> _loadInitTopStories() async* {
    yield HackerNewsLoadingState();
    try {
      _topStoryIds.addAll(await _repository.loadTopStoryIds());
    } catch (e) {
      _topStoriesStreamController.sink.addError('Unknown Error');
      return;
    }
    yield* loadMoreTopStories(pageSize: INIT_PAGE_SIZE);
    yield HackerNewsLoadedState(story: _topStories);
  }

  Stream<HackerNewsState> loadMoreTopStories({int pageSize = PAGE_SIZE}) async* {
    if (_isLoadingMoreTopStories) return;

    _isLoadingMoreTopStories = true;
    final storySize = min(_currentStoryIndex + pageSize, _topStoryIds.length);
    for (int index = _currentStoryIndex; index < storySize; index++) {
      try {
        _topStories.add(await _repository.loadStory(_topStoryIds[index]));
      } catch (e) {
        print('Failed to load story with id ${_topStoryIds[index]}');
      }
    }
    _currentStoryIndex = _topStories.length;
    _topStoriesStreamController.sink.add(_topStories);
    _isLoadingMoreTopStories = false;
  }

  bool hasMoreStories() => _currentStoryIndex < _topStoryIds.length;

  @override
  void dispose() {
    _topStoriesStreamController.close();
    _repository.dispose();
  }
}

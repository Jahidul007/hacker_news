import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hacker_news/bloc/hackernews_bloc/hackernews_event.dart';
import 'package:hacker_news/bloc/hackernews_bloc/hackernews_state.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/news_repository.dart';
import 'package:meta/meta.dart';

class HackerBloc extends Bloc<HackerNewsEvent, HackerNewsState> {
  static const int INIT_PAGE_SIZE = 20;
  static const int PAGE_SIZE = 10;

  final _topStoryIds = List<int>();
  final _topStories = List<Story>();
  final _repository = NewsRepository();

  var _currentStoryIndex = 0;



  NewsRepository repository;

  HackerBloc({@required this.repository}) : super(HackerNewsInitialState());

  @override
  // TODO: implement initialState
  HackerNewsState get initialState => HackerNewsInitialState();

  @override
  Stream<HackerNewsState> mapEventToState(HackerNewsEvent event) async* {
    if (event is FetchHackerNewsEvent) {
      yield HackerNewsLoadingState();

      try {
        _topStoryIds.addAll(await _repository.loadTopStoryIds());
        final storySize =
            min(_currentStoryIndex + PAGE_SIZE, _topStoryIds.length);
        for (int index = _currentStoryIndex; index < storySize; index++) {
          try {
            _topStories.add(await _repository.loadStory(_topStoryIds[index]));
          } catch (e) {
            print('Failed to load story with id ${_topStoryIds[index]}');
          }
        }
        yield HackerNewsLoadedState(story: _topStories);
      } catch (e) {
        yield HackerNewsErrorState(message: e.toString());
      }
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}

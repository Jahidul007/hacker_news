import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/data/repository/hacker_news/news_repository_implement.dart';

import 'base_bloc.dart';
class HackerNewsBloc extends Bloc {
  static const int INIT_PAGE_SIZE = 10;
  static const int PAGE_SIZE = 3;

  final _topStoryIds = List<int>();
  final _topStories = List<Story>();
  final _repository = NewsRepositoryImplement();

  var _isLoadingMoreTopStories = false;
  var _currentStoryIndex = 0;

  StreamController<List<Story>> _topStoriesStreamController = StreamController();

  Stream<List<Story>> get topStories => _topStoriesStreamController.stream;

  HackerNewsBloc() {
    _loadInitTopStories();
  }

  void _loadInitTopStories() async {
    try {
      _topStoryIds.addAll(await _repository.loadTopStoryIds());
    } catch (e) {
      _topStoriesStreamController.sink.addError('Unknown Error');
      return;
    }

    loadMoreTopStories(pageSize: INIT_PAGE_SIZE);
  }

  void loadMoreTopStories({int pageSize = PAGE_SIZE}) async {
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

  }
}
import 'package:hacker_news/data/repository/hacker_news/model/story.dart';

abstract class NewsRepository {
  Future<List<int>> loadTopStoryIds();

  loadStory(int topStoryId) {}
}
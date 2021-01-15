import 'dart:convert';

import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/repository.dart';

class TopStoryListBloc {
  final NewsRepository _repository = NewsRepository();

  List<Story> stories;

  topStories() async {
    final responses = await _repository.getTopStories();
    stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    return stories;
  }
}

final topStoryBloc = TopStoryListBloc();

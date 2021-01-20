import 'dart:convert';

import 'package:hacker_news/model/articles.dart';
import 'package:hacker_news/model/story.dart';
import 'package:http/http.dart' as http;
import 'package:hacker_news/app_helper/url_helper.dart';
import 'package:http/http.dart';

class NewsRepository {
  final _httpClient = http.Client();

  Future<List<Response>> getCommentsByStory(Story story) async {
    return Future.wait(story.kids.map((commentId) {
      return http.get(UrlHelper.urlForCommentById(commentId));
    }));
  }

/*
      Future<Response> _getStory(int storyId) {
          return http.get(UrlHelper.urlForStory(storyId));
      }
    Future<List<Response>> getTopStories() async {
    final response = await http.get(UrlHelper.urlForTopStories());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.take(10).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Unable to fetch data!");
    }
  }*/

  Future<Story> loadStory(int id) async {
    final response = await _httpClient
        .get('https://hacker-news.firebaseio.com/v0/item/$id.json');
    if (response.statusCode != 200)
      throw http.ClientException('Failed to load story with id $id');
print("story list ${Story.fromJSON(json.decode(response.body))}");
    return Story.fromJSON(json.decode(response.body));
  }

  Future<List<int>> loadTopStoryIds() async {
    final response = await _httpClient
        .get('https://hacker-news.firebaseio.com/v0/topstories.json');
    if (response.statusCode != 200)
      throw http.ClientException('Failed to load top story ids');

    return List<int>.from(json.decode(response.body));
  }

  void dispose() {
    // http =
    _httpClient.close();
  }
}

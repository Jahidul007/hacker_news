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

  Future<Story> loadStory(int id) async {
    final response = await _httpClient
        .get('https://hacker-news.firebaseio.com/v0/item/$id.json');
    if (response.statusCode != 200)
      throw http.ClientException('Failed to load story with id $id');
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
    _httpClient.close();
  }
}

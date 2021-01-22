import 'dart:convert';

import 'package:hacker_news/data/data_source/rest_source/comment_restapi/comment_api.dart';
import 'package:hacker_news/data/data_source/rest_source/hackersnews_api/hackernewsapi.dart';
import 'package:hacker_news/data/data_source/rest_source/rest_api.dart';
import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/data/repository/hacker_news/news_repository.dart';
import 'package:http/http.dart' as http;

class NewsRepositoryImplement implements NewsRepository {

  HackerNewsRestApi newsRestApi = HackerNewsRestApi();
  CommentsRestApi commentsRestApi = CommentsRestApi();

  Future<List> getCommentsByStory(Story story) async {
    return Future.wait(story.kids.map((commentId) {
      return commentsRestApi.getComments(commentId);
    }));
  }

  Future<Story> loadStory(int id) async {
    final response = await newsRestApi.getHackernews(id);
    return Story.fromJSON(json.decode(response.body));
  }

  Future<List<int>> loadTopStoryIds() async {
    final response = await newsRestApi.getHackernewsId();
    return List<int>.from(json.decode(response.body));
  }
}

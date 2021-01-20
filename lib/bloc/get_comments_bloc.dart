

import 'dart:convert';

import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/news_repository.dart';

class CommentsBloc{

  final NewsRepository _repository = NewsRepository();

  var comments;

  getComments(Story story) async {
    print(" story title ${story}");
    final responses = await _repository.getCommentsByStory(story);
    comments = responses.map((response) {
      final json = jsonDecode(response.body);
      print("comment response: $json");
      return Comment.fromJSON(json);
    }).toList();
    return comments;
  }

}

final commentsBloc = CommentsBloc();
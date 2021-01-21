import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hacker_news/data/repository/hacker_news/model/comments.dart';
import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/data/repository/hacker_news/news_repository.dart';
import 'package:meta/meta.dart';

import 'comments_event.dart';
import 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  NewsRepository repositoryComments;
  Story story;

  CommentsBloc({@required this.repositoryComments, this.story})
      : super(CommentsInitialState());

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is FetchCommentsEvent) {
      yield* loadingComments();
    }
  }

  Stream<CommentsState> loadingComments() async* {
    yield CommentsLoadingState();
    try {
      final responses = await repositoryComments.getCommentsByStory(story);
      final comments = responses.map((response) {
        final json = jsonDecode(response.body);
        return Comment.fromJSON(json);
      }).toList();
      yield CommentsLoadedState(comments: comments);
    } catch (e) {
      print("error $e");
      yield CommentsErrorState(message: e.toString());
    }
  }
}

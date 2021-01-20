import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_event.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_state.dart';
import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/news_repository.dart';
import 'package:meta/meta.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  NewsRepository repositoryComments;
  Story story;

  CommentsBloc({@required this.repositoryComments, this.story})
      : super(CommentsInitialState());

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is FetchCommentsEvent) {
      print("event : $event");
      yield CommentsLoadingState();
      try {
        final responses = await repositoryComments.getCommentsByStory(story);
        final comments = responses.map((response) {
          final json = jsonDecode(response.body);
          return Comment.fromJSON(json);
        }).toList();
        print(" comments $comments");
        yield CommentsLoadedState(comments: comments);
      } catch (e) {
        print("error $e");
        yield CommentsErrorState(message: e.toString());
      }
    }
  }
}

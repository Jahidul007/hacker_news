import 'package:bloc/bloc.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_event.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_state.dart';
import 'package:hacker_news/bloc/news_bloc/news_event.dart';
import 'package:hacker_news/bloc/news_bloc/news_state.dart';
import 'package:hacker_news/model/articles.dart';
import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/repository.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';
class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {

  NewsRepository repositoryComments;
  Story story;

  CommentsBloc({this.story}) : super(CommentsInitialState());

  @override
  // TODO: implement initialState
  CommentsState get initialState => CommentsInitialState();

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield CommentsLoadingState();
      try {
        List<Comment> comment = (await repositoryComments.getCommentsByStory(story)).cast<Comment>();
        print(" comments $comment");
        yield CommentsLoadedState(comments: comment);
      } catch (e) {
        print("error $e");
        yield CommentsErrorState(message: e.toString());
      }
    }
  }

}
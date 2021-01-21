import 'package:equatable/equatable.dart';
import 'package:hacker_news/data/repository/hacker_news/model/comments.dart';
import 'package:meta/meta.dart';

abstract class CommentsState extends Equatable {}

class CommentsInitialState extends CommentsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CommentsLoadingState extends CommentsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CommentsLoadedState extends CommentsState {

  List<Comment> comments;

  CommentsLoadedState({@required this.comments});

  @override
  // TODO: implement props
  List<Object> get props => [comments];
}

class CommentsErrorState extends CommentsState {

  String message;

  CommentsErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
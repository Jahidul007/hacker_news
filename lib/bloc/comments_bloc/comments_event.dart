import 'package:equatable/equatable.dart';
import 'package:hacker_news/model/story.dart';

abstract class CommentsEvent extends Equatable {}

class FetchCommentsEvent extends CommentsEvent {

  @override
  // TODO: implement props
  List<Object> get props => null;
}
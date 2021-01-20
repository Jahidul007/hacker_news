import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hacker_news/model/articles.dart';
import 'package:hacker_news/model/story.dart';
import 'package:meta/meta.dart';
abstract class HackerNewsState extends Equatable {}

class HackerNewsInitialState extends HackerNewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HackerNewsLoadingState extends HackerNewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HackerNewsLoadedState extends HackerNewsState {

  List<Story> story;
  HackerNewsLoadedState({@required this.story});

  @override
  // TODO: implement props
  List<Object> get props => [story];
}

class HackerNewsErrorState extends HackerNewsState {

  String message;

  HackerNewsErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
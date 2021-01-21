import 'package:bloc/bloc.dart';
import 'package:hacker_news/data/repository/sportsnews/model/articles.dart';
import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/data/repository/sportsnews/article_repository.dart';
import 'package:hacker_news/data/repository/hacker_news/news_repository.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';

import 'news_event.dart';
import 'news_state.dart';
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  ArticleRepository repository;

  ArticleBloc({@required this.repository}) : super(ArticleInitialState());

  @override
  // TODO: implement initialState
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield* loadingArticle();
    }
  }

  Stream<ArticleState> loadingArticle()async*{
    yield ArticleLoadingState();
    try {
      List<Articles> articles = await repository.getArticles();
      yield ArticleLoadedState(articles: articles);
    } catch (e) {
      yield ArticleErrorState(message: e.toString());
    }
  }



}
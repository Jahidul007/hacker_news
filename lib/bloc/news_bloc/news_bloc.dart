import 'package:bloc/bloc.dart';
import 'package:hacker_news/bloc/news_bloc/news_event.dart';
import 'package:hacker_news/bloc/news_bloc/news_state.dart';
import 'package:hacker_news/model/articles.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/repository.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  ArticleRepository repository;

  ArticleBloc({@required this.repository}) : super(ArticleInitialState());

  @override
  // TODO: implement initialState
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }

}
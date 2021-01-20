import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/Route/arguments.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_bloc.dart';
import 'package:hacker_news/bloc/get_hacker_news_bloc.dart';
import 'package:hacker_news/bloc/hackernews_bloc/hackernews_bloc.dart';
import 'package:hacker_news/bloc/news_bloc/news_bloc.dart';
import 'package:hacker_news/repository/article_repository_implement.dart';
import 'package:hacker_news/repository/news_repository.dart';
import 'package:hacker_news/screens/comment_test_page.dart';
import 'package:hacker_news/screens/comments_list_page.dart';
import 'package:hacker_news/screens/hacker_news_page.dart';
import 'package:hacker_news/screens/news_test_page.dart';
import 'package:hacker_news/screens/splash_screen.dart';
import 'package:hacker_news/screens/test_page.dart';
import 'package:provider/provider.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Arguments args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.homeRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HackerNewsPage.newsPage:
        return MaterialPageRoute(
            builder: (context) => Provider<HackerNewsBloc>(
                  create: (context) => HackerNewsBloc(),
                  dispose: (context, bloc) => bloc.dispose(),
                  child: HackerNewsPage(),
                ));
      case CommentListPage.commentsPage:
        return MaterialPageRoute(builder: (_) => CommentListPage(args));
      case TestPage.testPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ArticleBloc>(
                  create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
                  child: TestPage(),
                ));
      case CommentPage.comPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<CommentsBloc>(
              create: (context) => CommentsBloc(repositoryComments: NewsRepository()),
              child: CommentPage(),
            ));
      case NewsTestPage.newsTestPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<HackerBloc>(
              create: (context) => HackerBloc(repository: NewsRepository()),
              child: NewsTestPage(),
            ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/Route/arguments.dart';
import 'package:hacker_news/bloc/get_top_stories_bloc.dart';
import 'package:hacker_news/bloc/news_bloc/news_bloc.dart';
import 'package:hacker_news/repository/repository.dart';
import 'package:hacker_news/screens/comments_list_page.dart';
import 'package:hacker_news/screens/hacker_news_page.dart';
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
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

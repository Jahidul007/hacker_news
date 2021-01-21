import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/repository/sportsnews/sports_news_repository_implement.dart';
import 'package:hacker_news/data/repository/hacker_news/news_repository_implement.dart';
import 'package:hacker_news/ui/features/comments/comments_bloc/comments_bloc.dart';
import 'package:hacker_news/ui/features/comments/comments_list_page.dart';
import 'package:hacker_news/ui/features/hacker_news/hackernews_bloc/hackernews_bloc.dart';
import 'package:hacker_news/ui/features/hacker_news/news_page.dart';
import 'package:hacker_news/ui/features/splash/splash_screen.dart';
import 'package:hacker_news/ui/features/sports/news_bloc/news_bloc.dart';
import 'package:hacker_news/ui/features/sports/sports_page.dart';
import 'package:hacker_news/ui/features/test/bloc/get_hacker_news_bloc.dart';
import 'package:hacker_news/ui/features/test/hacker_news_page.dart';

import 'package:provider/provider.dart';

import 'arguments.dart';

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
        return MaterialPageRoute(builder: (context) => BlocProvider<CommentsBloc>(
          create: (context) => CommentsBloc(repositoryComments: NewsRepositoryImplement(),story: args.story),
          child: CommentListPage(args),
        ));
      case SportsPage.sportsPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ArticleBloc>(
                  create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
                  child: SportsPage(),
                ));
      case NewsPage.newsTestPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<HackerBloc>(
              create: (context) => HackerBloc(repository: NewsRepositoryImplement()),
              child: NewsPage(),
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

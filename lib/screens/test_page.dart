import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/news_bloc/news_bloc.dart';
import 'package:hacker_news/bloc/news_bloc/news_event.dart';
import 'package:hacker_news/bloc/news_bloc/news_state.dart';
import 'package:hacker_news/model/articles.dart';
import 'package:hacker_news/model/story.dart';

class TestPage extends StatefulWidget {
  static const String testPage = '/testPage';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: Container(
        child: BlocListener<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticleInitialState) {
                print("initaial page ");
                return buildLoading();
              } else if (state is ArticleLoadingState) {
                print("initaial page loading");
                return buildLoading();
              } else if (state is ArticleLoadedState) {
                print(" page loaded");
                return buildArticleList(state.articles);
              } else if (state is ArticleErrorState) {
                print("error");
                return buildErrorUi(state.message);
              } else{
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(

              title: Text(articles[pos].title??""),
              subtitle: Text(articles[pos].author??""),
            ),
            /*onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },*/
          ),
        );
      },
    );
  }
}

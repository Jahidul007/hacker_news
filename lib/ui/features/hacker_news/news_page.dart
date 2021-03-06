import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/ui/Route/arguments.dart';
import 'package:hacker_news/ui/features/comments/comments_list_page.dart';
import 'package:hacker_news/ui/features/sports/sports_page.dart';
import 'package:hacker_news/ui/language/language_page.dart';

import 'hackernews_bloc/hackernews_bloc.dart';
import 'hackernews_bloc/hackernews_event.dart';
import 'hackernews_bloc/hackernews_state.dart';


class NewsPage extends StatefulWidget {
  static const String newsTestPage = '/';

  @override
  _NewsTestPageState createState() => _NewsTestPageState();
}

class _NewsTestPageState extends State<NewsPage> {
  HackerBloc hackerBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hackerBloc = BlocProvider.of<HackerBloc>(context);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Sports':
        Navigator.pushNamed(context, SportsPage.sportsPage);
        break;
      case 'Language':
        Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage() ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    hackerBloc = BlocProvider.of<HackerBloc>(context);
    hackerBloc.add(FetchHackerNewsEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text("Hacker News"),
        actions: <Widget>[
          PopupMenuButton<String>(
              color: Colors.orangeAccent,
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Sports','Language'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ],
      ),
      body: Container(
        child: BlocListener<HackerBloc, HackerNewsState>(
          listener: (context, state) {
            if (state is HackerNewsErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else {
              Container();
            }
          },
          child: BlocBuilder<HackerBloc, HackerNewsState>(
            builder: (context, state) {
              if (state is HackerNewsInitialState) {
                print("initial page ");
                return buildLoading();
              } else if (state is HackerNewsLoadingState) {
                print("initial page loading");
                return buildLoading();
              } else if (state is HackerNewsLoadedState) {
                print(" page loaded");
                return _buildTopStories(state.story);
              } else if (state is HackerNewsErrorState) {
                print("error");
                return buildErrorUi(state.message);
              } else {
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

  Widget _buildTopStories(List<Story> topStories) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: topStories.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildStoryCardView(story: topStories[index]);
      },
    );
  }

  Widget _buildStoryCardView({Story story}) {
    return Card(
      child: ListTile(
        title: Text(
          story.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          story.author,
          style: TextStyle(color: Colors.orange, fontStyle: FontStyle.italic),
        ),
        trailing: Container(
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            alignment: Alignment.center,
            width: 40,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                story.score.toString(),
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
        onTap: () async {
          /*final responses = await NewsRepository().getCommentsByStory(story);
          final comments = responses.map((response) {
            final json = jsonDecode(response.body);
            return Comment.fromJSON(json);
          }).toList();*/
          Navigator.pushNamed(context, CommentListPage.commentsPage,
              arguments: Arguments(story));
        },
      ),
    );
  }
}

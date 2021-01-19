import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/Route/arguments.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_bloc.dart';
import 'package:hacker_news/bloc/comments_bloc/comments_event.dart';
import 'package:hacker_news/bloc/get_top_stories_bloc.dart';
import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/repository.dart';
import 'package:hacker_news/screens/comments_list_page.dart';
import 'package:hacker_news/screens/test_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HackerNewsPage extends StatefulWidget {
  static const String newsPage = '/newsPage';

  @override
  _HackerNewsPageState createState() => _HackerNewsPageState();
}

class _HackerNewsPageState extends State<HackerNewsPage> {
  HackerNewsBloc _bloc;
  CommentsBloc commentsBloc;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreTopStoriesIfNeed);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<HackerNewsBloc>(context);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Sports':
        Navigator.pushNamed(context, TestPage.testPage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
        //centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
              color: Colors.orangeAccent,
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Sports'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.topStories,
        builder: (BuildContext context, AsyncSnapshot<List<Story>> snapshot) {
          if (snapshot.hasData)
            return _buildTopStories(topStories: snapshot.data);
          if (snapshot.hasError)
            return Center(child: Text('${snapshot.error}'));
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _loadMoreTopStoriesIfNeed() {
    final offsetToEnd = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;
    final threshold = MediaQuery.of(context).size.height / 3;
    final shouldLoadMore = offsetToEnd < threshold;
    if (shouldLoadMore) {
      _bloc.loadMoreTopStories();
    }
  }

  Widget _buildTopStories({List<Story> topStories}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount:
          _bloc.hasMoreStories() ? topStories.length + 1 : topStories.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == topStories.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
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
          final responses = await NewsRepository().getCommentsByStory(story);
          final comments = responses.map((response) {
            final json = jsonDecode(response.body);
            return Comment.fromJSON(json);
          }).toList();
          Navigator.pushNamed(context, CommentListPage.commentsPage,
              arguments: Arguments(comments, story));
        },
      ),
    );
  }
}

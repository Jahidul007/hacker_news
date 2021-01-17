import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/bloc/get_comments_bloc.dart';
import 'package:hacker_news/bloc/get_top_stories_bloc.dart';
import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/repository/repository.dart';
import 'package:hacker_news/screens/comments_list_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Story> _stories = List<Story>();

  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {

    final responses = await NewsRepository().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    setState(() {
      _stories = stories;
    });
  }

  @override
  Widget build(BuildContext context) {
    topStoryBloc..topStories();
    return Scaffold(
        appBar: AppBar(
          title: Text("Hacker News"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: ListView.builder(
          itemCount: _stories.length,
          itemBuilder: (_, index) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: ListTile(
                  onTap: () async{
                    final story = this._stories[index];
                    final responses = await NewsRepository().getCommentsByStory(story);
                    final comments = responses.map((response) {
                      final json = jsonDecode(response.body);
                      return Comment.fromJSON(json);
                    }).toList();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentListPage(
                                story: story,
                                comments: comments)));
                  },
                  title: Text(_stories[index].title,
                      style: TextStyle(fontSize: 18)),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            "${_stories[index].commentIds.length}",
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            );
          },
        ));
  }
}
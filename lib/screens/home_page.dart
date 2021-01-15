import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/bloc/get_comments_bloc.dart';
import 'package:hacker_news/bloc/get_top_stories_bloc.dart';
import 'package:hacker_news/screens/comments_list_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    topStoryBloc..topStories();
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);

    topStoryBloc..topStories();
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

          itemCount: topStoryBloc.stories.length,
          itemBuilder: (_, index) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ListTile(
                    onTap: () {
                      final story = topStoryBloc.stories[index];

                      commentsBloc..getComments(story);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentListPage(
                                  story: story,
                                  comments: commentsBloc.comments)));
                    },
                    title: Text(topStoryBloc.stories[index].title,
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
                              "${topStoryBloc.stories[index].commentIds.length}",
                              style: TextStyle(color: Colors.white)),
                        )),
                  ),
                ),
              );
          },
        ));
  }
}

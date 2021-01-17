import 'package:flutter/material.dart';
import 'package:hacker_news/bloc/get_comments_bloc.dart';
import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';

class CommentListPage extends StatefulWidget {
  final List<Comment> comments;
  final Story story;

  bool isLoading = false;

  CommentListPage({this.story, this.comments});

  @override
  _CommentListPageState createState() => _CommentListPageState(story, comments);
}

class _CommentListPageState extends State<CommentListPage> {
  Story story;
  final List<Comment> comments;

  _CommentListPageState(this.story, this.comments);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(story.title), backgroundColor: Colors.orange),
        body: ListView.builder(
          itemCount: story.kids.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Container(
                    alignment: Alignment.center,
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text("${1 + index}",
                        style: TextStyle(fontSize: 22, color: Colors.white))),
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    this.widget.comments[index].text ?? "",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ));
          },
        ));
  }
}

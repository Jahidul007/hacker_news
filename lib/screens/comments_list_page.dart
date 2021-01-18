import 'package:flutter/material.dart';
import 'package:hacker_news/Route/arguments.dart';
import 'package:hacker_news/bloc/get_comments_bloc.dart';
import 'package:hacker_news/model/comments.dart';
import 'package:hacker_news/model/story.dart';

class CommentListPage extends StatefulWidget {
  static const String commentsPage = '/commentsPage';
final Arguments args;
  CommentListPage(this.args);
  /*final List<Comment> comments;
  final Story story;*/


  //CommentListPage({this.story, this.comments});

  @override
  _CommentListPageState createState() => _CommentListPageState(args);
}

class _CommentListPageState extends State<CommentListPage> {
  _CommentListPageState( this.args);
  final Arguments args;

/*  Story story;
  final List<Comment> comments;

  _CommentListPageState(this.story, this.comments);*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("arguments ${args}");
    return Scaffold(
        appBar:
            AppBar(title: Text(args.story.title), backgroundColor: Colors.orange),
        body: ListView.builder(
          itemCount: args.story.kids.length,
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
                    args.comments[index].text ?? "",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ));
          },
        ));
  }
}

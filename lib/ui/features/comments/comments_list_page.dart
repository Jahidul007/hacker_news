import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/repository/hacker_news/model/comments.dart';
import 'package:hacker_news/data/repository/hacker_news/model/story.dart';
import 'package:hacker_news/ui/Route/arguments.dart';

import 'comments_bloc/comments_bloc.dart';
import 'comments_bloc/comments_event.dart';
import 'comments_bloc/comments_state.dart';

class CommentListPage extends StatefulWidget {
  static const String commentsPage = '/commentsPage';
  final Arguments args;

  CommentListPage(this.args);

  @override
  _CommentListPageState createState() => _CommentListPageState(args);
}

class _CommentListPageState extends State<CommentListPage> {
  _CommentListPageState(this.args);

  final Arguments args;

  CommentsBloc commentsBloc;

  @override
  void initState() {
    super.initState();
    commentsBloc = BlocProvider.of<CommentsBloc>(context);
    commentsBloc.add(FetchCommentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(args.story.title), backgroundColor: Colors.orange),
      body: Container(
        child: BlocListener<CommentsBloc, CommentsState>(
          listener: (context, state) {
            if (state is CommentsErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<CommentsBloc, CommentsState>(
            builder: (context, state) {
              if (state is CommentsInitialState) {
                print("initial comment page ");
                return buildLoading();
              } else if (state is CommentsLoadingState) {
                print("initial comment page loading");
                return buildLoading();
              } else if (state is CommentsLoadedState) {
                print("comment page loaded");
                return buildArticleList(state.comments);
              } else if (state is CommentsErrorState) {
                print("comment error");
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

  Widget buildArticleList(List<Comment> articles) {
    return ListView.builder(
      itemCount: articles.length??0,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
                leading: Container(
                    alignment: Alignment.center,
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text("${1 + pos}",
                        style: TextStyle(fontSize: 22, color: Colors.white))),
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    articles[pos].text ?? "",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                )),
            onTap: () {
              //_launchUrl(articles[pos].url);
            },
          ),
        );
      },
    );
  }
}

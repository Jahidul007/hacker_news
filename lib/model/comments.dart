import 'package:hacker_news/model/story.dart';

class Comment {
  String text = "";
  final int commentId;
  Story story;
  Comment({this.commentId,this.text});

  factory Comment.fromJSON(Map<String,dynamic> json) {
    return Comment(
        commentId: json["id"],
        text: json["text"]
    );
  }

}
import 'package:hacker_news/model/story.dart';


class StoryResponse {
  final List<Story> story;
  final String error;

  StoryResponse(this.story, this.error);

  StoryResponse.fromJson(Map<String, dynamic> json)
      : story =
  (json["story"] as List).map((i) => new Story.fromJSON(i)).toList(),
        error = "";

  StoryResponse.withError(String errorValue)
      : story = List(),
        error = errorValue;
}
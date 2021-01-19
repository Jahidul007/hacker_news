class UrlHelper {

  static String urlForStory(int storyId) {
    return "https://hacker-news.firebaseio.com/v0/item/${storyId}.json?print=pretty";
  }

  static String urlForTopStories() {
    return "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";
  }

  static String urlForCommentById(int commentId) {
    return "https://hacker-news.firebaseio.com/v0/item/${commentId}.json?print=pretty";
  }

  static String cricArticleUrl = "https://newsapi.org/v2/top-headlines?sources=espn-cric-info&apiKey=46e4b8e106ec4cd4b85291f274bf3266";

}
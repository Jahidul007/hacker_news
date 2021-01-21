import 'dart:convert';

import 'package:hacker_news/data/app_helper/url_helper.dart';
import 'package:hacker_news/data/repository/sportsnews/model/articles.dart';
import 'package:hacker_news/data/repository/sportsnews/article_repository.dart';

import 'package:http/http.dart' as http;

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(UrlHelper.cricArticleUrl);
    print("data ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}

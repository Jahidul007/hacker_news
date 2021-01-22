import 'dart:convert';

import 'package:hacker_news/data/app_helper/url_helper.dart';
import 'package:hacker_news/data/data_source/rest_source/rest_api.dart';
import 'package:hacker_news/data/data_source/rest_source/sportsnews_api/sportsnews_api.dart';
import 'package:hacker_news/data/repository/sportsnews/model/articles.dart';
import 'package:hacker_news/data/repository/sportsnews/sports_news_repository.dart';

import 'package:http/http.dart' as http;

class ArticleRepositoryImpl implements ArticleRepository {
  SportsRestApi restApi = SportsRestApi();

  @override
  Future<List<Articles>> getArticles() async {
    var response = await restApi.getSports();
    var data = json.decode(response.body);
    List<Articles> articles = ApiResultModel.fromJson(data).articles;
    return articles;
  }
}

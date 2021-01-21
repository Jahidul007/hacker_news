import 'package:hacker_news/data/repository/sportsnews/model/articles.dart';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}
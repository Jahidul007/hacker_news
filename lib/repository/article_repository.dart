import 'package:hacker_news/model/articles.dart';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}
import 'package:flutter/material.dart';
import 'package:hacker_news/ui/Route/route.dart';
import 'package:hacker_news/ui/features/hacker_news/news_page.dart';
import 'package:hacker_news/ui/features/splash/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hacker News',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: NewsPage.newsTestPage,
    );
  }
}

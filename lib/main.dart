import 'package:flutter/material.dart';
import 'package:hacker_news/screens/hacker_news_page.dart';
import 'package:hacker_news/screens/news_page.dart';
import 'package:hacker_news/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'Route/route.dart';
import 'bloc/get_hacker_news_bloc.dart';

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
      initialRoute: SplashScreen.homeRoute,
    );
  }
}

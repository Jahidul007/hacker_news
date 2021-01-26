import 'package:flutter/material.dart';
import 'package:hacker_news/ui/Route/route.dart';
import 'package:hacker_news/ui/features/hacker_news/news_page.dart';
import 'package:hacker_news/ui/features/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hacker_news/ui/language/app_localizations.dart';

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
      supportedLocales: [
        Locale('en', 'US'),
        Locale('sk', 'SK'),
      ],
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        // TODO: uncomment the line below after codegen
        // AppLocalizations.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      onGenerateRoute: Router.generateRoute,
      initialRoute: NewsPage.newsTestPage,
    );
  }
}

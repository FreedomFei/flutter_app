import 'package:flutter/material.dart';
import 'package:flutter_app/manga/mainPage.dart';

class MangaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangaApp',
      home: MainPage(),
      initialRoute: '/',
      routes: {
//        '/info': (context) => MangaInfoPage(),
      },
    );
  }
}

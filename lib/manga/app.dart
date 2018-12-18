import 'package:flutter/material.dart';

import 'home.dart';
import 'info.dart';

class MangaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangaApp',
      home: MangaHomePage(),
      initialRoute: '/',
      routes: {
        '/info': (context) {
          return MangaInfoPage();
        },
      },
    );
  }
}

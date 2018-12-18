import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class ShrineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shrine app',
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    print('getRoute');
    if (settings.name != '/login') {
      print('return null');
      return null;
    }
    print('return MaterialPageRoute');
    return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => LoginPage(),
        fullscreenDialog: true);
  }
}

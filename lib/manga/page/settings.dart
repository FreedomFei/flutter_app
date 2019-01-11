import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.datetime,
            )
          ],
        ),
      ),
    );
  }
}
//new TextField(
//onChanged: (String s)=>print("clicked search" + s),
//decoration: const InputDecoration(
//icon: const Icon(Icons.search),
//),
//)
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print('LoginPage');
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                Image.asset('assets/diamond.png'),
                Icon(
                  Icons.ac_unit,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text('SHRING'),
              ],
            ),
            SizedBox(
              height: 120.0,
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'please input username',
                labelText: 'UserName',
              ),
              controller: _usernameController,
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'please input password',
                labelText: 'Password',
              ),
              obscureText: true,
              controller: _passwordController,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: Text('Cancel'),
                ),
                RaisedButton(
                  child: Text('Next'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

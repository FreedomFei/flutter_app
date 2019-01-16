import 'package:flutter/material.dart';
import 'package:flutter_app/manga/page/category.dart';
import 'package:flutter_app/manga/page/home.dart';
import 'package:flutter_app/manga/page/settings.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _navCurrentIndex = 0;

  List<Widget> _pageChildren = [
    CategoryPage(),
    HomePage(),
    SettingsPage(),
  ];

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _dialogExitApp(context),
      child: Scaffold(
        body: PageView.builder(
//        onPageChanged: (int index) => _pageController.jumpToPage(index),
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) =>
              _pageChildren[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _navCurrentIndex,
            onTap: (index) {
              _onTabTapped(index);
              _pageController.jumpToPage(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favorite'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ]),
      ),
    );
  }

  void _onTabTapped(int index) {
    print('_onTabTapped $index');

    setState(() {
      _navCurrentIndex = index;
    });
  }

  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("是否退出"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("取消")),
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("确定"))
              ],
            ));
  }
}

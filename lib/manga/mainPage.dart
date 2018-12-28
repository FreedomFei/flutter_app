import 'package:flutter/material.dart';
import 'package:flutter_app/manga/category.dart';
import 'package:flutter_app/manga/home.dart';
import 'package:flutter_app/manga/homePage.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _navCurrentIndex = 0;

  List<Widget> _pageChildren = [
    HomePage(),
    CategoryPage(),
    MangaHomePage(),
  ];

  var _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
//        onPageChanged: (int index) => _pageController.jumpToPage(index),
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => _pageChildren[index],
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
    );
  }

  void _onTabTapped(int index) {
    print('_onTabTapped $index');

    setState(() {
      _navCurrentIndex = index;
    });
  }
}

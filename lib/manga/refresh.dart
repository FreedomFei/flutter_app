import 'package:flutter/material.dart';

class SwipeToRefresh extends StatefulWidget {

  final Widget child;

  const SwipeToRefresh({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SwipeToRefreshState();
  }
}

class SwipeToRefreshState extends State<SwipeToRefresh> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: null, onRefresh: _refresh);
  }

  _refresh() {}
}

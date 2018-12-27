import 'package:flutter/material.dart';

import 'info.dart';
import 'model/manga.dart';
import 'server.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print('HomePage createState');
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  int _currentPage = 0;

  int _page = 0;
  List<HomeManga> _mangas = [];

  ScrollController _scrollController = new ScrollController();
  bool _performingRequest = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('HomePage initState');

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _handleMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('HomePage build');

    return Offstage(
      offstage: _currentPage != _page,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            child: _buildManaCards(),
            onRefresh: _handleRefresh),
      ),
    );
  }

  @override
  void dispose() {
    print('HomePage dispose');

    _scrollController.dispose();
    super.dispose();
  }

  ///下拉刷新
  Future<void> _handleRefresh() {
    return getMangaHomeList(page: _page = 0).then((value) {
      setState(() {
        _mangas = value;
      });
    });
  }

  ///加载更多
  void _handleMore() {
    if (!_performingRequest) {
      setState(() {
        _performingRequest = true;
      });

      getMangaHomeList(page: ++_page).then((value) {
        setState(() {
          _mangas.addAll(value);
          _performingRequest = false;
        });
      });
    }
  }

  ///卡片集
  Widget _buildManaCards() {
    return GridView.builder(
        itemCount: _mangas.length + 1,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
//          print('manga cards $index');

          if (index == _mangas.length) {
            return _buildProgressIndicator();
          }

          return _buildCard(context, _mangas[index]);
        });
  }

  ///加载更多UI
  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: _performingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  ///单个卡片
  Widget _buildCard(BuildContext context, HomeManga manga) {
    var imageUrl;

    if (manga.im != null) {
      imageUrl = imageBaseUrl + manga.im.toString();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MangaInfoPage(id: manga.i.toString());
        }));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 5 / 3,
              child: imageUrl == null
                  ? Image.asset('assets/AttachmentPlaceholder-Dark.png')
                  : Image.network(imageUrl),
            ),
            Text(
              manga.t,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(manga.h.toString()),
          ],
        ),
      ),
    );
  }
}
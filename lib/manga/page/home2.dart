//import 'package:flutter/material.dart';
//
//import 'info.dart';
//import 'model/manga.dart';
//import 'server.dart';
//
//class MangaHomePage extends StatefulWidget {
//  @override
//  State createState() {
//    return MangaHomePageState();
//  }
//}
//
//class MangaHomePageState extends State<MangaHomePage>
//    with AutomaticKeepAliveClientMixin {
//  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//      GlobalKey<RefreshIndicatorState>();
//
//  int _page = 0;
//  List<HomeManga> _mangas = [];
//
//  ScrollController _scrollController = new ScrollController();
//
//  bool isPerformingRequest = false;
//
//  @override
//  bool get wantKeepAlive => true;
//
//  @override
//  void initState() {
//    super.initState();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//
//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels ==
//          _scrollController.position.maxScrollExtent) {
//        _handleMore();
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Home'),
//      ),
//      body: RefreshIndicator(
//        key: _refreshIndicatorKey,
//        onRefresh: _handleRefresh,
//        child: _buildManaCards(context),
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    _scrollController.dispose();
//    super.dispose();
//  }
//
//  ///下拉刷新
//  Future<void> _handleRefresh() {
////    return FutureBuilder<List<HomeManga>>(
////      future: getMangaHomeList(page: _page = 0),
////      builder: (BuildContext context, AsyncSnapshot<List<HomeManga>> snapshot) {
////        if (snapshot.hasData) {
////          return _buildManaCards(context, snapshot.data);
////        } else if (snapshot.hasError) {
////          return Text('${snapshot.error}');
////        }
////        return Center(child: CircularProgressIndicator());
////      },
////    );
//
//    return getMangaHomeList(page: _page = 0).then((value) {
//      setState(() {
//        _mangas = value;
//      });
//    });
//  }
//
//  ///加载更多
//  _handleMore() async {
//    if (!isPerformingRequest) {
//      setState(() {
//        isPerformingRequest = true;
//      });
//
//      await getMangaHomeList(page: ++_page).then((value) {
//        setState(() {
//          _mangas.addAll(value);
//          isPerformingRequest = false;
//        });
//      });
//    }
//  }
//
//  ///加载更多UI
//  Widget _buildProgressIndicator() {
//    return Padding(
//      padding: EdgeInsets.all(8.0),
//      child: Center(
//        child: Opacity(
//          opacity: isPerformingRequest ? 1.0 : 0.0,
//          child: CircularProgressIndicator(),
//        ),
//      ),
//    );
//  }
//
//  ///卡片集
//  Widget _buildManaCards(BuildContext context) {
////    return GridView.count(
////        crossAxisCount: 2,
////        padding: EdgeInsets.all(16.0),
////        children: _mangas.map((manga) {
////          return _buildCard(context, manga);
////        }).toList());
//
//    return GridView.builder(
//        itemCount: _mangas.length + 1,
//        gridDelegate:
//            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//        controller: _scrollController,
//        itemBuilder: (BuildContext context, int index) {
//          print('$index');
//
//          if (index == _mangas.length) {
//            return _buildProgressIndicator();
//          }
//
//          return _buildCard(context, _mangas[index]);
//        });
//  }
//
//  ///单个卡片
//  Widget _buildCard(BuildContext context, HomeManga manga) {
//    var imageUrl;
//
//    if (manga.im != null) {
//      imageUrl = imageBaseUrl + manga.im.toString();
//    }
//
//    return GestureDetector(
//      onTap: () {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return MangaInfoPage(id: manga.i.toString());
//        }));
//      },
//      child: Card(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            AspectRatio(
//              aspectRatio: 5 / 3,
//              child: imageUrl == null
//                  ? Image.asset('assets/AttachmentPlaceholder-Dark.png')
//                  : Image.network(imageUrl),
//            ),
//            Text(
//              manga.t,
//              maxLines: 2,
//              overflow: TextOverflow.ellipsis,
//            ),
//            Text(manga.h.toString()),
//          ],
//        ),
//      ),
//    );
//  }
//}

import 'package:flutter/material.dart';

import 'info.dart';
import 'model/manga.dart';
import 'server.dart';

class MangaHomePage extends StatefulWidget {
  @override
  State createState() {
    return MangaHomePageState();
  }
}

class MangaHomePageState extends State<MangaHomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int _page = 0;
  List<HomeManga> _mangas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: _buildManaCards(context, _mangas),
      ),
    );
  }

  Future<void> _handleRefresh() {
//    return FutureBuilder<List<HomeManga>>(
//      future: getMangaHomeList(),
//      builder: (BuildContext context, AsyncSnapshot<List<HomeManga>> snapshot) {
//        if (snapshot.hasData) {
//          return _buildManaCards(context, snapshot.data);
//        } else if (snapshot.hasError) {
//          return Text('${snapshot.error}');
//        }
//        return Center(child: CircularProgressIndicator());
//      },
//    );

    return getMangaHomeList().then((value) {
      setState(() {
        _mangas = value;
      });
    });
  }

  Future<void> _handleMore() {
    return getMangaHomeList(page: _page++).then((value) {
      setState(() {
        _mangas.addAll(value);
      });
    });
  }

  int _length = 0;

  Widget _buildManaCards(BuildContext context, List<HomeManga> mangas) {
//    return GridView.count(
//        crossAxisCount: 2,
//        padding: EdgeInsets.all(16.0),
//        children: mangas.map((manga) {
//          return _buildCard(context, manga);
//        }).toList());

    setState(() {
      _length += _mangas.length;
    });

    return GridView.builder(
        itemCount: _length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          if (index == _length - 1) {
            Future.delayed(
                Duration.zero,
                () => setState(() {
                      print('setState');
                      _handleMore();
                    }));
          }
          print('$index');

          return _buildCard(context, mangas[index]);
        });
  }

  Widget _buildCard(BuildContext context, HomeManga manga) {
    var imageUrl = imageBaseUrl + manga.im.toString();

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
              child: Image.network(imageUrl),
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

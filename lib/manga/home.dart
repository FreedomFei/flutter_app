import 'package:flutter/material.dart';

import 'info.dart';
import 'model/manga.dart';
import 'server.dart';

class MangaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _MangaListWidget(homeMangaList: getMangaHomeList()),
    );
  }
}

class _MangaListWidget extends StatelessWidget {
  final Future<List<HomeManga>> homeMangaList;

  _MangaListWidget({Key key, this.homeMangaList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HomeManga>>(
      future: homeMangaList, //可以直接调用getHomeMangaList()
      builder: (BuildContext context, AsyncSnapshot<List<HomeManga>> snapshot) {
        if (snapshot.hasData) {
          return _buildManaCards(context, snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildManaCards(BuildContext context, List<HomeManga> mangas) {
    return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: mangas.map((manga) {
          return _buildCard(context, manga);
        }).toList());
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

//class MyApp extends StatelessWidget {
//  final Future<Post> post;
//
//  MyApp({Key key, this.post}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<Post>(
//      future: post,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return Text(snapshot.data.title);
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//
//        // By default, show a loading spinner
//        return CircularProgressIndicator();
//      },
//    );
//  }
//}
//
//// ignore: must_be_immutable
//class MyApp2 extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return _myAppState();
//  }
//}
//
//// ignore: camel_case_types
//class _myAppState extends State<MyApp2> {
//  Future<Post> post;
//
//  @override
//  void initState() {
//    super.initState();
//    post = fetchPost();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<Post>(
//      future: post,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return Text(snapshot.data.title);
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//
//        // By default, show a loading spinner
//        return CircularProgressIndicator();
//      },
//    );
//  }
//}

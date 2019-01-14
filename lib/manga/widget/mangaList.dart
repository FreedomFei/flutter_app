import 'package:flutter/material.dart';
import 'package:flutter_app/manga/model/manga.dart';
import 'package:flutter_app/manga/page/info.dart';
import 'package:flutter_app/manga/server.dart';

class MangaList extends StatelessWidget {
  final _mangas;

  MangaList(this._mangas);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: _mangas.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
//          print('manga cards $index');
          return _buildCard(context, _mangas[index]);
        });
  }

  ///单个卡片
  Widget _buildCard(BuildContext context, HomeManga manga) {
    var imageUrl = manga.im == null ? null : baseImageUrl + manga.im;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MangaInfoPage(id: manga.i);
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
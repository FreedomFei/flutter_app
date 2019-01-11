import 'package:flutter/material.dart';
import 'package:flutter_app/manga/model/chapter.dart';
import 'package:flutter_app/manga/server.dart';

class ChapterPage extends StatelessWidget {
  final String chapterId;

  const ChapterPage({Key key, this.chapterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(''),
//      ),
      body: _buildViewer(),
    );
  }

  Widget _buildViewer() {
    return FutureBuilder<Chapter>(
      future: getChapterPages(chapterId),
      builder: (BuildContext context, AsyncSnapshot<Chapter> snapshot) {
        if (snapshot.hasData) {
          return _buildPages(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildPages(Chapter chapter) {
    var images = chapter.images.reversed.toList();
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          var image = images[index];
          var imageUrl = baseImageUrl + image[1];
          print(index.toString() + ':' + imageUrl);
          return Column(
            children: <Widget>[
              Text('${image[0]}'),
              Center(
                child:
//              MyImage(
//                  imageProvider: NetworkImage(imageUrl),
//                ),
                    FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: imageUrl,
                ),
              ),
            ],
          );
        });
  }
}

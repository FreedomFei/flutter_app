import 'package:flutter/material.dart';

import 'model/info.dart';
import 'server.dart';
import 'viewer.dart';

class MangaInfoPage extends StatelessWidget {
  final String id;

  MangaInfoPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manga'),
      ),
      body: _InfoWidget(info: getMangaInfo(id)),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  final Future<Info> info;

  const _InfoWidget({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Info>(
        future: info,
        builder: (BuildContext context, AsyncSnapshot<Info> snapshot) {
          if (snapshot.hasData) {
            var info = snapshot.data;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildInfo(context, info),
                  SizedBox(height: 16.0),
                  _buildDescription(info.description),
                  SizedBox(height: 16.0),
                  Text(
                    'Chapters',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  SizedBox.fromSize(
                      size: Size.fromHeight(200.0),
                      child: _buildChapters(info.chapters)),
//                  _buildChapters(info.chapters),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  ///manga信息
  Widget _buildInfo(BuildContext context, Info info) {
    var textTheme = Theme.of(context).textTheme;

    var imageUrl = info.image == null ? null : imageBaseUrl + info.image;

//    FadeInImage.assetNetwork(
//      placeholder: 'assets/AttachmentPlaceholder-Dark.png',
//      image: imageUrl,
//      fit: BoxFit.cover,
//      height: 180.0,
//      width: 120.0,
//    )

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(4.0),
          elevation: 4.0,
          child: imageUrl == null
              ? Image.asset(
                  'assets/AttachmentPlaceholder-Dark.png',
                  fit: BoxFit.cover,
                  height: 180.0,
                  width: 120.0,
                )
              : Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 180.0,
                  width: 120.0,
                ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${info.title}',
                style: textTheme.title,
              ),
              SizedBox(height: 8.0),
              Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(info.categories.toString()),
              SizedBox(height: 8.0),
              Text(
                'Other',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Author:${info.author}'),
              Text('Artist:${info.artist}'),
              Text('released:${info.released}'),
              Text('Chapters:${info.chapters_len}'),
            ],
          ),
        )
      ],
    );
  }

  ///描述
  Widget _buildDescription(description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text('$description'),
      ],
    );
  }

  ///章节集合
  Widget _buildChapters(List<List> chapters) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: chapters.length,
        itemBuilder: (BuildContext context, int index) {
          var chapter = chapters[index];
          print(chapter.toString());

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChapterPage(chapterId: chapter[3])));
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        chapter[2] == null
                            ? chapter[0].toString()
                            : chapter[2].toString(),
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                      ),
                    ),
//                    Text(
//                      double
//                          .tryParse(chapter[1].toString())
//                          .isNaN
//                          ? 'date null'
//                          : DateFormat('yyyy-MM-dd HH:mm').format(
//                          DateTime.fromMillisecondsSinceEpoch(
//                              (chapter[1] * 1000).toInt())),
//                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

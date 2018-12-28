import 'package:flutter/material.dart';
import 'package:flutter_app/manga/info.dart';
import 'package:flutter_app/manga/model/manga.dart';
import 'package:flutter_app/manga/server.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
//  SingleTickerProviderStateMixin
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: categoryNames.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _buildTabs(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabViews(),
      ),
    );
  }

  List<Tab> _buildTabs() {
    print('category length:' + categoryNames.length.toString());
    return List.generate(categoryNames.length, (index) {
      return Tab(
        text: categoryNames[index],
      );
    });
  }

  List<Widget> _buildTabViews() {
    return List.generate(categoryNames.length, (index) {
      var categoryName = categoryNames[index];

      var categoryChild = categoryChildren[categoryName];

      return _buildManaCards(categoryChild);
    });
  }

  ///卡片集
  Widget _buildManaCards(_mangas) {
    return GridView.builder(
        itemCount: _mangas.length + 1,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return _buildCard(context, _mangas[index]);
        });
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

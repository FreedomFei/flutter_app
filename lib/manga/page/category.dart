import 'package:flutter/material.dart';
import 'package:flutter_app/manga/server.dart' as server;
import 'package:flutter_app/manga/widget/mangaList.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryPageState();
  }
}

///通过 SingleTickerProviderStateMixin 实现 Tab 的动画切换效果
///(ps 如果有需要多个嵌套动画效果，你可能需要TickerProviderStateMixin)。
class CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<CategoryPage> {
//  SingleTickerProviderStateMixin
  TabController _tabController;

  List<String> _categoryNames = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _categoryNames = server.categoryNames;
    _tabController = TabController(length: _categoryNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> _buildTabs() {
    print('category length:' + _categoryNames.length.toString());
    return List.generate(_categoryNames.length, (index) {
      return Tab(
        text: _categoryNames[index],
      );
    });
  }

  List<Widget> _buildTabViews() {
    return List.generate(_categoryNames.length, (index) {
      var categoryName = _categoryNames[index];

      var categoryChild = server.categories[categoryName];
//      var categoryChild = categories[categoryName];

      return MangaList(categoryChild);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/manga/model/manga.dart';
import 'package:flutter_app/manga/page/info.dart';
import 'package:flutter_app/manga/server.dart' as server;
import 'package:flutter_app/manga/widget/mangaList.dart';
import 'package:intl/intl.dart';

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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _SearchDelegate _delegate = _SearchDelegate();

  TabController _tabController;

  List<String> _categoryNames = [];
  Map<String, List<HomeManga>> _categories = Map();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _tabController = TabController(length: _categoryNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
//        flexibleSpace: SafeArea(
//          child: TabBar(
//            controller: _tabController,
//            isScrollable: true,
//            tabs: _buildTabs(),
//          ),
//        ),
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch<String>(
                context: context,
                delegate: _delegate,
              );
            },
          ),
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _refreshIndicatorKey.currentState.show();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _buildTabs(),
        ),
      ),
      body: RefreshIndicator(
        //todo:有瑕疵
        key: _refreshIndicatorKey,
        child: TabBarView(
          controller: _tabController,
          children: _buildTabViews(),
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  ///下拉刷新
  Future<void> _handleRefresh() {
    print('refresh');

    return server.getMangaHomeList().then((List<HomeManga> value) {
      setState(() {
//        _categoryNames = server.categoryNames;
        _categories = server.handleCategory(value);

        _categories.values
            .toList()
            .map((l) {
              return l.length;
            })
            .toList()
            .sort();
        _categoryNames = _categories.keys.toList();

        _tabController?.animateTo(0);
        _tabController =
            TabController(length: _categoryNames.length, vsync: this);
      });
    });
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

//      var categoryChild = server.categories[categoryName];
//      return MangaList(categoryChild);
      return MangaList(_categories[categoryName]);
    });
  }
}

///SearchDelegate
class _SearchDelegate extends SearchDelegate<String> {
  List<String> _history = <String>[];

  ///顶部搜索栏
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  ///构建建议列表
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : server.homeMangas.expand((HomeManga manga) {
            if ('${manga.t}'.toLowerCase().contains(query.toLowerCase())) {
              return ['${manga.t}'];
            } else {
              return [];
            }
          });

    return _SuggestionList(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        query = suggestion;

        showResults(context); //会回调buildResults
      },
    );
  }

  ///搜索结果
  @override
  Widget buildResults(BuildContext context) {
    print('search:$query');
    if (query == null || query.trim() == '') {
      return Center(
        child: Text(
          '"$query"\n Your heart no a little B number.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    _history.insert(0, query);
    _history = _history.toSet().toList();

    return _ResultCard(
      searched: query,
      searchDelegate: this,
    );
  }

  ///顶部搜索
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: 不好，被发现了';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

///搜索结果列表
class _ResultCard extends StatelessWidget {
  const _ResultCard({this.searched, this.searchDelegate});

  final String searched;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<HomeManga> suggestions = server.homeMangas
        .where((HomeManga manga) => '${manga.t}'.contains(searched))
        .toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int i) {
          HomeManga manga = suggestions[i];

          return GestureDetector(
            onTap: () {
//              searchDelegate.close(context, searched);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MangaInfoPage(id: manga.i);
              }));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '${manga.t}',
                      style: theme.textTheme.headline.copyWith(fontSize: 20.0),
                    ),
                    Text(manga.ld == null
                        ? 'no date'
                        : DateFormat('yyyy-MM-dd HH:mm:ss').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (manga.ld * 1000).toInt()))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

///建议列表
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: Text(suggestion),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

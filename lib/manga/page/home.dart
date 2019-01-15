import 'package:flutter/material.dart';
import 'package:flutter_app/manga/model/manga.dart';
import 'package:flutter_app/manga/page/info.dart';
import 'package:flutter_app/manga/server.dart' as server;
import 'package:flutter_app/manga/widget/mangaList.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print('HomePage createState');
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<HomeManga> _mangas = [];

  final _SearchDelegate _delegate = _SearchDelegate();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('HomePage initState');

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('HomePage build');

    return Scaffold(
      appBar: AppBar(
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
            tooltip: 'More (not implemented)',
            icon: Icon(
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Icons.more_horiz
                  : Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        child: MangaList(_mangas),
        onRefresh: _handleRefresh,
      ),
    );
  }

  @override
  void dispose() {
    print('HomePage dispose');

    super.dispose();
  }

  ///下拉刷新
  Future<void> _handleRefresh() {
    return server.getMangaHomeList().then((value) {
      setState(() {
        _mangas = value;
      });
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
                        ? 'unknow'
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

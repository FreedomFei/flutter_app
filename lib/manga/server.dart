import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model/chapter.dart';
import 'model/info.dart';
import 'model/manga.dart';

const baseImageUrl = 'https://cdn.mangaeden.com/mangasimg/';

List<String> _categoryNames = <String>[];

//Future<List<String>>
List<String> getCategoryNames({page = 0, length = 30}) {
//  _categoryNames.clear();
  if (_categoryNames.isEmpty) {
    getMangaHomeList().then((List<HomeManga> mangas) {
      Map<String, List<HomeManga>> categoryChildren = handleCategory(mangas);

//    _categoryNames = handleCategorySort(baseHomeManga.manga);
      categoryChildren.values
          .toList()
          .map((l) {
            return l.length;
          })
          .toList()
          .sort();

      _categoryNames = categoryChildren.keys.toList();
      print('111');
      print(_categoryNames);

      return _categoryNames;
    });
  } else {
    print('222');
    return _categoryNames;
  }
}

Map<String, List<HomeManga>> _categories = Map();

//Map<String, List<HomeManga>>
getCategories({page = 0, length = 30}) {
  if (_categories.isEmpty) {
    getMangaHomeList().then((List<HomeManga> mangas) {
      _categories = handleCategory(mangas);

      return _categories;
    });
  } else {
    return _categories;
  }
}

List<HomeManga> _homeMangas = <HomeManga>[];

//Future<List<HomeManga>>
getMangaList() {
  if (_homeMangas.isEmpty) {
    getMangaHomeList().then((List<HomeManga> mangas) {
      _homeMangas = mangas;
      return _homeMangas;
    });
  } else {
    return _homeMangas;
  }
}

///get mangas
Future<List<HomeManga>> getMangaHomeList({page = 0, length = 30}) async {
  final response =
//      await http.get('https://www.mangaeden.com/api/list/0/?p=$page&l=$length');
      await http.get('https://www.mangaeden.com/api/list/0/');
  print(response.request.url);

  if (response.statusCode == 200) {
    BaseHomeManga baseHomeManga =
        BaseHomeManga.fromJson(json.decode(response.body));

    _categories = handleCategory(baseHomeManga.manga);

//    _categoryNames = handleCategorySort(baseHomeManga.manga);
    _categories.values
        .toList()
        .map((l) {
          return l.length;
        })
        .toList()
        .sort();

    _categoryNames = _categories.keys.toList();
//    print(_categoryNames);
    _homeMangas = baseHomeManga.manga;
    return baseHomeManga.manga;
  } else {
    throw Exception('Failed to load data');
  }
}

/// category sort by count
List<String> handleCategorySort(List<HomeManga> mangas) {
  var categories = <String>[];
  mangas.forEach((e) {
    e.c.forEach((c) {
      categories.add(c);
    });
  });

  var category = <String, int>{};
  categories.forEach((e) {
    if (!category.keys.contains(e)) {
      category[e] = 1;
    } else {
      category[e] = ++category[e];
    }
  });

  category.values.toList().sort();
  print(category);
  return category.keys.toList();
}

///mangas by category
Map<String, List<HomeManga>> handleCategory(List<HomeManga> mangas) {
  Map<String, List<HomeManga>> result = Map();

  mangas.forEach((manga) {
    manga.c.forEach((category) {
      (result[category] ??= List()).add(manga);
    });
  });
  return result;
}

///get mannga info
Future<Info> getMangaInfo(String mangaId) async {
  final response =
      await http.get('https://www.mangaeden.com/api/manga/$mangaId/');
  print(response.request.url);

//  if (response.statusCode == 200) {
//    var info = Info.fromJson(json.decode(response.body));
//    return info;
//  } else {
//    throw Exception('Failed to load post');
//  }
  return compute(parseInfo, response.body); //??
}

Info parseInfo(String responseBody) {
  return Info.fromJson(json.decode(responseBody));
}

///get chapter pages
Future<Chapter> getChapterPages(String chapterId) async {
  final response =
      await http.get('https://www.mangaeden.com/api/chapter/$chapterId/');
  print(response.request.url);

  return compute(parseChapterPage, response.body);
}

Chapter parseChapterPage(String responseBody) {
  return Chapter.fromJson(json.decode(responseBody));
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model/chapter.dart';
import 'model/info.dart';
import 'model/manga.dart';
import 'model/post.dart';

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
//    print(response.body);
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

const imageBaseUrl = 'https://cdn.mangaeden.com/mangasimg/';

Future<List<HomeManga>> getMangaHomeList({page = 0, length = 30}) async {
  final response =
      await http.get('https://www.mangaeden.com/api/list/0/?p=$page&l=$length');
  print(response.request.url);

  if (response.statusCode == 200) {
    var baseHomeManga = BaseHomeManga.fromJson(json.decode(response.body));
    return baseHomeManga.manga;
  } else {
    throw Exception('Failed to load data');
  }
}

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

Future<Chapter> getChapterPages(String chapterId) async {
  final response =
      await http.get('https://www.mangaeden.com/api/chapter/$chapterId/');
  print(response.request.url);

  return compute(parseChapterPage, response.body);
}

Chapter parseChapterPage(String responseBody) {
  return Chapter.fromJson(json.decode(responseBody));
}

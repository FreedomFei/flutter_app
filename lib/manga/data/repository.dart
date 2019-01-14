//import 'package:flutter_app/manga/server.dart';
//
//List<String> _categoryNames = <String>[];
//
////Future<List<String>>
//List<String> getCategoryNames({page = 0, length = 30}) {
////  _categoryNames.clear();
//  if (_categoryNames.isEmpty) {
//    server.getMangaHomeList().then((List<HomeManga> mangas) {
//      Map<String, List<HomeManga>> categoryChildren = handleCategory(mangas);
//
////    _categoryNames = handleCategorySort(baseHomeManga.manga);
//      categoryChildren.values
//          .toList()
//          .map((l) {
//            return l.length;
//          })
//          .toList()
//          .sort();
//
//      _categoryNames = categoryChildren.keys.toList();
//      print('111');
//      print(_categoryNames);
//
//      return _categoryNames;
//    });
//  } else {
//    print('222');
//    return _categoryNames;
//  }
//}
//
//Map<String, List<HomeManga>> _categories = Map();
//
////Map<String, List<HomeManga>>
//getCategories({page = 0, length = 30}) {
//  if (_categories.isEmpty) {
//    getMangaHomeList().then((List<HomeManga> mangas) {
//      _categories = handleCategory(mangas);
//
//      return _categories;
//    });
//  } else {
//    return _categories;
//  }
//}
//
//List<HomeManga> _homeMangas = <HomeManga>[];
//
////Future<List<HomeManga>>
//getMangaList() {
//  if (_homeMangas.isEmpty) {
//    getMangaHomeList().then((List<HomeManga> mangas) {
//      _homeMangas = mangas;
//      return _homeMangas;
//    });
//  } else {
//    return _homeMangas;
//  }
//}

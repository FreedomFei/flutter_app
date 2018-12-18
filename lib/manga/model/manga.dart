class BaseHomeManga {
  final int end;
  final List<HomeManga> manga;
  final int page;
  final int start;
  final int total;

  BaseHomeManga({this.end, this.manga, this.page, this.start, this.total});

  factory BaseHomeManga.fromJson(Map<String, dynamic> json) {
//    List list = json['manga'] as List;
//
//    print('1');
//    print(list.runtimeType);
//    list.map((e) {
//      print('2');
//    });
//    return null;

    List<HomeManga> homeMangas = [];
    (json['manga'] as List).forEach((e) {
      Map<String, dynamic> map = e as Map<String, dynamic>;

      homeMangas.add(HomeManga.fromJson(map));
    });

    return BaseHomeManga(
      end: json['end'],
      manga: homeMangas,
//      manga: (json['manga'] as List)?.map((e) =>
//          e == null ? null : HomeManga.fromJson(e as Map<String, dynamic>)),
      page: json['page'],
      start: json['start'],
      total: json['total'],
    );
  }
}

class HomeManga {
  //alias
  final String a;

  //category
  final List<String> c;

  //hits
  final int h;

  //ID
  final String i;

  //image
  final String im;

  //last chapter date
  final double ld;

  //status
  final int s;

  //title
  final String t;

  HomeManga({this.a, this.c, this.h, this.i, this.im, this.ld, this.s, this.t});

  factory HomeManga.fromJson(Map<String, dynamic> json) {
    return HomeManga(
      a: json['a'],
      c: List.from(json['c']),
      h: json['h'],
      i: json['i'],
      im: json['im'],
      ld: json['ld'],
      s: json['s'],
      t: json['t'],
    );
  }
}

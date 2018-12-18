class Chapter {
  final List<List> images;

  Chapter({this.images});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
        images: (json['images'] as List).map<List>((e) => e).toList());
  }
}

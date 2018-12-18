void main() {
  List list = [
    'artist',
    'author',
    'categories',
    'chapters',
    'chapters_len',
    'created',
    'description',
    'hits',
    'image',
    'last_chapter_date',
    'released',
  ];
  var list2 = list.map((e) {
    return '\n' + e + ':' + 'json[\'$e\']';
  }).toList();

  print(list2);
}

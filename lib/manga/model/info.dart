class Info {
  final String title;
  final String artist;
  final String author;
  final List<String> categories;

  ///[
  ///5, # <-- chapter's number
  ///1275542373.0, # <-- chapter's date
  ///"5", # <-- chapter's title
  ///"4e711cb0c09225616d037cc2" # <-- chapter's ID (chapter.id in the next section)
  ///]
  final List<List> chapters;
  final int chapters_len;
  final double created;
  final String description;
  final int hits;
  final String image;
  final double last_chapter_date;
  final int released;

  Info({
    this.title,
    this.artist,
    this.author,
    this.categories,
    this.chapters,
    this.chapters_len,
    this.created,
    this.description,
    this.hits,
    this.image,
    this.last_chapter_date,
    this.released,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'],
      artist: json['artist'],
      author: json['author'],
      categories: List.from(json['categories']),
      chapters: (json['chapters'] as List).map<List>((e) => e).toList(),
      chapters_len: json['chapters_len'],
      created: json['created'],
      description: json['description'],
      hits: json['hits'],
      image: json['image'],
      last_chapter_date: json['last_chapter_date'],
      released: json['released'],
    );
  }
}

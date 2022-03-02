// ignore_for_file: file_names
class News {
  News({
    this.id,
    this.title,
    this.brief,
  });

  String? id;
  String? title;
  String? brief;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        brief: json["brief"],
      );
}

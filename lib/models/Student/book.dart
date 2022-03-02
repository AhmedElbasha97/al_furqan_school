class Books {
  Books({
    this.title,
    this.file,
  });

  String? title;
  String? file;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        title: json["title"],
        file: json["file"],
      );
}

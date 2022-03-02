// ignore_for_file: file_names
class NewsDetails {
  NewsDetails({
    this.title,
    this.description,
    this.images,
    this.video,
  });

  String? title;
  String? description;
  List<String?>? images = [];
  String? video;

  factory NewsDetails.fromJson(Map<String, dynamic> json) {
    NewsDetails data = NewsDetails(
      title: json["title"],
      description: json["description"],
      images: [],
      video: json["video"],
    );
    if (json["image"] != null) {
      data.images!.add(json["image"]);
    }
    for (int index = 2; index <= 8; index++) {
      if (json["image$index"] != null) {
        data.images!.add(json["image$index"]);
      }
    }
    return data;
  }
}

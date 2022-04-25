import 'dart:convert';

List<About> aboutFromJson(String str) => List<About>.from(json.decode(str).map((x) => About.fromJson(x)));

String aboutToJson(List<About> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class About {
  About({
    this.title,
    this.description,
    this.image,
  });

  String? title;
  String? description;
  String? image;

  factory About.fromJson(Map<String, dynamic> json) => About(
    title: json["title"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "image": image,
  };
}

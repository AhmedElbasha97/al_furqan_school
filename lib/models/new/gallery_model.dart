import 'dart:convert';

List<Gallery> galleryFromJson(String str) => List<Gallery>.from(json.decode(str).map((x) => Gallery.fromJson(x)));

String galleryToJson(List<Gallery> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gallery {
  Gallery({
    this.id,
    this.title,
    this.img,
  });

  String? id;
  String? title;
  String? img;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    id: json["id"],
    title: json["title"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "img": img,
  };
}

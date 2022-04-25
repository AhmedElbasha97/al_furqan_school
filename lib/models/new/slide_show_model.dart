import 'dart:convert';

List<SlideShowImage> slideShowImageFromJson(String str) => List<SlideShowImage>.from(json.decode(str).map((x) => SlideShowImage.fromJson(x)));

String slideShowImageToJson(List<SlideShowImage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlideShowImage {
  SlideShowImage({
    this.id,
    this.title,
    this.img,
  });

  String? id;
  String? title;
  String? img;

  factory SlideShowImage.fromJson(Map<String, dynamic> json) => SlideShowImage(
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

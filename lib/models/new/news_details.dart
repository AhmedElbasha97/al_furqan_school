import 'dart:convert';

NewsDetailsModel newsDetailsModelFromJson(String str) => NewsDetailsModel.fromJson(json.decode(str));

String newsDetailsModelToJson(NewsDetailsModel data) => json.encode(data.toJson());

class NewsDetailsModel {
  NewsDetailsModel({
    this.title,
    this.description,
    this.image,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
    this.video,
  });

  String? title;
  String? description;
  String? image;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;
  String? video;

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) => NewsDetailsModel(
    title: json["title"],
    description: json["description"],
    image: json["image"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    image6: json["image6"],
    image7: json["image7"],
    image8: json["image8"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "image": image,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "image6": image6,
    "image7": image7,
    "image8": image8,
    "video": video,
  };
}

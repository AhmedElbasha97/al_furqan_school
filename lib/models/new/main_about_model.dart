// To parse this JSON data, do
//
//     final mainAboutModel = mainAboutModelFromJson(jsonString);

import 'dart:convert';

MainAboutModel mainAboutModelFromJson(String str) => MainAboutModel.fromJson(json.decode(str));

String mainAboutModelToJson(MainAboutModel data) => json.encode(data.toJson());

class MainAboutModel {
  MainAboutModel({
    this.title,
    this.brief,
    this.description,
    this.image,
  });

  String? title;
  String? brief;
  String? description;
  String? image;

  factory MainAboutModel.fromJson(Map<String, dynamic> json) => MainAboutModel(
    title: json["title"],
    brief: json["brief"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "brief": brief,
    "description": description,
    "image": image,
  };
}

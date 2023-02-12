import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.brief,
    this.img,

  });

  String? id;
  String? title;
  String? brief;
  String? img;


  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["id"],
    title: json["title"],
    brief: json["brief"] ,
    img: json["img"],

  );

  Map<String, dynamic> toJson() => {
    "id": id ,
    "title": title,
    "brief": brief,
    "img": img,

  };
}

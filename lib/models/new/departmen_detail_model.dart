import 'dart:convert';

DepartmentDataModel depatmentDataModelFromJson(String str) => DepartmentDataModel.fromJson(json.decode(str));

String depatmentDataModelToJson(DepartmentDataModel data) => json.encode(data.toJson());

class DepartmentDataModel {
  DepartmentDataModel({
    this.id,
    this.title,
    this.brief,
    this.img,
  });

  String? id;
  String? title;
  String? brief;
  String? img;

  factory DepartmentDataModel.fromJson(Map<String, dynamic> json) => DepartmentDataModel(
    id: json["id"],
    title: json["title"],
    brief: json["brief"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "brief": brief,
    "img": img,
  };
}

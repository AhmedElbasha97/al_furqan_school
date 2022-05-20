// To parse this JSON data, do
//
//     final depatmentModel = depatmentModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentModel> depatmentModelFromJson(String str) => List<DepartmentModel>.from(json.decode(str).map((x) => DepartmentModel.fromJson(x)));

String depatmentModelToJson(List<DepartmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
  DepartmentModel({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

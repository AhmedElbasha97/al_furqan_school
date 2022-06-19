
import 'dart:convert';

List<SchedulesModel> schedulesModelFromJson(String str) => List<SchedulesModel>.from(json.decode(str).map((x) => SchedulesModel.fromJson(x)));

String schedulesModelToJson(List<SchedulesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchedulesModel {
  SchedulesModel({
    this.id,
    this.img,
  });

  String? id;
  String? img;

  factory SchedulesModel.fromJson(Map<String, dynamic> json) => SchedulesModel(
    id: json["id"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
  };
}

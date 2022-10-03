import 'dart:convert';

List<DepartmentDataModel> departmentDataModelFromJson(String str) => List<DepartmentDataModel>.from(json.decode(str).map((x) => DepartmentDataModel.fromJson(x)));

String departmentDataModelToJson(List<DepartmentDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentDataModel {
  DepartmentDataModel({
    this.title,
    this.brief,
    this.activity,
  });

  String? title;
  String? brief;
  List<Activity>? activity;

  factory DepartmentDataModel.fromJson(Map<String, dynamic> json) => DepartmentDataModel(
    title: json["title"],
    brief: json["brief"],
    activity: json["activity"] == null ? null : List<Activity>.from(json["activity"].map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "brief": brief,
    "activity": activity == null ? null : List<dynamic>.from(activity!.map((x) => x.toJson())),
  };
}

class Activity {
  Activity({
    this.title,
    this.desc,
    this.img,
  });

  String? title;
  String? desc;
  String? img;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    title: json["title"],
    desc: json["desc"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "desc": desc,
    "img": img,
  };
}

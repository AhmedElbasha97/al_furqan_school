
import 'dart:convert';

StudentListModel studentListModelFromJson(String str) => StudentListModel.fromJson(json.decode(str));

String studentListModelToJson(StudentListModel data) => json.encode(data.toJson());

class StudentListModel {
  StudentListModel({
    this.status,
    this.msg,
    this.info,
  });

  String? status;
  String? msg;
  Info? info;

  factory StudentListModel.fromJson(Map<String, dynamic> json) => StudentListModel(
    status: json["status"],
    msg: json["msg"],
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "info": null == info ?     // ignore: prefer_null_aware_operators
null : info?.toJson(),
  };
}

class Info {
  Info({
    this.id,
    this.name,
    this.studentName,
    this.infoClass,
  });

  String? id;
  String? name;
  String? studentName;
  String? infoClass;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    name: json["name"],
    studentName: json["student_name"],
    infoClass: json["class"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "student_name": studentName,
    "class": infoClass,
  };
}

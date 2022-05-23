
import 'dart:convert';

StudentListModel studentListModelFromJson(String str) => StudentListModel.fromJson(json.decode(str));

String studentListModelToJson(StudentListModel data) => json.encode(data.toJson());

class StudentListModel {
  StudentListModel({
    this.response,
    this.status,
    this.msg,
    this.info,
    this.allStudents,
  });

  String? response;
  String? status;
  String? msg;
  Info? info;
  List<Info>? allStudents;

  factory StudentListModel.fromJson(Map<String, dynamic> json) => StudentListModel(
    response: json["response"],
    status: json["status"],
    msg: json["msg"],
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    allStudents: json["all_students"] == null ? null : List<Info>.from(json["all_students"].map((x) => Info.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "status": status,
    "msg": msg,
    "info": info == null ? null : info?.toJson(),
    "all_students": allStudents == null ? null : List<dynamic>.from(allStudents!.map((x) => x.toJson())),
  };
}

class Info {
  Info({
    this.id,
    this.studentName,
    this.infoClass,
    this.name,
  });

  String? id;
  String? studentName;
  String? infoClass;
  String? name;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    studentName: json["student_name"],
    infoClass: json["class"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_name": studentName,
    "class": infoClass,
    "name": name,
  };
}

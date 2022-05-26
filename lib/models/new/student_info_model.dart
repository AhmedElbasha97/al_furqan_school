import 'dart:convert';

StudentInfoModel studentInfoModelFromJson(String str) => StudentInfoModel.fromJson(json.decode(str));

String studentInfoModelToJson(StudentInfoModel data) => json.encode(data.toJson());
class StudentInfoModel {
  StudentInfoModel({
    this.id,
    this.name,
    this.email,
    this.class1,
    this.class2,
    this.class3,
  });

  String? id;
  String? name;
  String? email;
  String? class1;
  String? class2;
  String? class3;

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) => StudentInfoModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    class1: json["class1"],
    class2: json["class2"],
    class3: json["class3"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "class1": class1,
    "class2": class2,
    "class3": class3,
  };
}

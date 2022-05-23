import 'dart:convert';

List<Student> studentFromJson(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
    this.id,
    this.name,
    this.parent,
  });

  String? id;
  String? name;
  String? parent;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
  };
}

// To parse this JSON data, do
//
//     final subjectDetails = subjectDetailsFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators, prefer_if_null_operators

import 'dart:convert';

List<SubjectDetails> subjectDetailsFromJson(String str) => List<SubjectDetails>.from(json.decode(str).map((x) => SubjectDetails.fromJson(x)));

String subjectDetailsToJson(List<SubjectDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectDetails {
  SubjectDetails({
    this.id,
    this.title,
    this.brief,
    this.file,
  });

  String? id;
  String? title;
  String? brief;
  String? file;

  factory SubjectDetails.fromJson(Map<String, dynamic> json) => SubjectDetails(
    id: json["id"] ?? null,
    title: json["title"] ?? null,
    brief: json["brief"] == null ? null :json["brief"],
    file: json["file"] == null ? null : json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "brief": brief == null ? null :brief,
    "file": file == null ? null : file,
  };
}
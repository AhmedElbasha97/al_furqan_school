// ignore_for_file: file_names
class HomeWorkDetailsTeacherModel {
  HomeWorkDetailsTeacherModel({
    this.id,
    this.title,
    this.date,
    this.teacherName,
    this.homeworkDet,
    this.homeworkFile,
  });

  String? id;
  String? title;
  String? date;
  String? teacherName;
  String? homeworkDet;
  String? homeworkFile;

  factory HomeWorkDetailsTeacherModel.fromJson(Map<String, dynamic> json) =>
      HomeWorkDetailsTeacherModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        date: json["date"] ?? "",
        teacherName: json["teacher_name"],
        homeworkDet: json["homework_det"] ?? "",
        homeworkFile:
            json["homework_file"] ?? "",
      );
}

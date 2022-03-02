// ignore_for_file: file_names
class HomeWorkTeacher {
  HomeWorkTeacher({
    this.id,
    this.title,
    this.date,
    this.homeWorkTeacherClass,
  });

  String? id;
  String? title;
  String? date;
  String? homeWorkTeacherClass;

  factory HomeWorkTeacher.fromJson(Map<String, dynamic> json) =>
      HomeWorkTeacher(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        date: json["date"] ?? "",
        homeWorkTeacherClass: json["class"] ?? "",
      );
}

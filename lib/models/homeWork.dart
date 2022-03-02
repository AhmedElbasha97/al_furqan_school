// ignore_for_file: file_names
class HomeWork {
  HomeWork({
    this.id,
    this.title,
    this.date,
    this.teacherName,
  });

  String? id;
  String? title;
  String? date;
  dynamic teacherName;

  factory HomeWork.fromJson(Map<String, dynamic> json) => HomeWork(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        teacherName: json["teacher_name"],
      );
}

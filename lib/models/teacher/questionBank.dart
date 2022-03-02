// ignore_for_file: file_names

class QuestionBankTeacher {
  QuestionBankTeacher({
    this.id,
    this.title,
    this.date,
    this.questionBankTeacherClass,
  });

  String? id;
  String? title;
  String? date;
  String? questionBankTeacherClass;

  factory QuestionBankTeacher.fromJson(Map<String, dynamic> json) =>
      QuestionBankTeacher(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        date: json["date"] ?? "",
        questionBankTeacherClass: json["class"] ?? "",
      );
}

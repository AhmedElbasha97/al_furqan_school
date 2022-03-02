class MessageDetailsTeacherModel {
  MessageDetailsTeacherModel({
    this.to,
    this.title,
    this.text,
    this.date,
  });

  String? to;
  String? title;
  String? text;
  String? date;

  factory MessageDetailsTeacherModel.fromJson(Map<String, dynamic> json) =>
      MessageDetailsTeacherModel(
          to: json["to"] ?? "",
          title: json["title"] ?? "",
          text: json["text"] ?? "",
          date: json["date"] ?? "");
}

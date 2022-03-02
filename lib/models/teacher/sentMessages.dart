// ignore_for_file: file_names

class SentMessagesTeacher {
  SentMessagesTeacher({
    this.msgId,
    this.to,
    this.title,
    this.date,
  });

  String? msgId;
  String? to;
  String? title;
  String? date;

  factory SentMessagesTeacher.fromJson(Map<String, dynamic> json) =>
      SentMessagesTeacher(
        msgId: json["msg_id"] ?? "",
        to: json["to"] ?? "",
        title: json["title"] ?? "",
        date: json["date"] ?? "",
      );
}

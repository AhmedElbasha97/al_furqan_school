// ignore_for_file: file_names
class AskedQuestion {
  AskedQuestion({
    this.msgId,
    this.from,
    this.title,
    this.date,
  });

  String? msgId;
  String? from;
  String? title;
  DateTime? date;

  factory AskedQuestion.fromJson(Map<String, dynamic> json) => AskedQuestion(
        msgId: json["msg_id"],
        from: json["from"],
        title: json["title"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );
}

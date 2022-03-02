// ignore_for_file: file_names
class MessageDetailsStudent {
    MessageDetailsStudent({
        this.from,
        this.title,
        this.text,
        this.date,
    });

    String? from;
    String? title;
    String? text;
    DateTime? date;

    factory MessageDetailsStudent.fromJson(Map<String, dynamic> json) => MessageDetailsStudent(
        from: json["from"],
        title: json["title"],
        text: json["text"],
        date: DateTime.parse(json["date"]),
    );

}

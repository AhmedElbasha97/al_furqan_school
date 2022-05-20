// ignore_for_file: file_names
class QuestionDetails {
    QuestionDetails({
        this.id,
        this.title,
        this.date,
        this.fileDet,
        this.fileLink,
    });

    String? id;
    String? title;
    String? date;
    String? fileDet;
    String? fileLink;

    factory QuestionDetails.fromJson(Map<String, dynamic> json) => QuestionDetails(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        fileDet: json["file_det"],
        fileLink: json["file_link"],
    );

}

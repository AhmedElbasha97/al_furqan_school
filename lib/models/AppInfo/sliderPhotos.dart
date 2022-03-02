// ignore_for_file: file_names
class SliderData {
  SliderData({
    this.id,
    this.title,
    this.img,
  });

  String? id;
  String? title;
  String? img;

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
        id: json["id"],
        title: json["title"],
        img: json["img"],
      );
}

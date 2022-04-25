import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:dio/dio.dart';

class StarScreenServices{
  String baseURL = "https://alforqanschools.sch.qa/site/api/";
  String slideShow="slide.php";

  Future<List<SlideShowImage>> getSlideShowPhotos({String? id}) async {
    List<SlideShowImage> list = [];
    Response response;
    response = await Dio().get(
      baseURL+slideShow,
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(SlideShowImage.fromJson(element));
      });
    }
    return list;
  }

}
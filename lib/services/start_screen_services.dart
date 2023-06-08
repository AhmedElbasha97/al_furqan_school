// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/new/department_model.dart';
import 'package:al_furqan_school/models/new/main_about_model.dart';
import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:dio/dio.dart';

class StarScreenServices{
  String slideShow="${baseUrl}slide.php";
  String mainSlideShow="${baseUrl}slide_app.php";
  String mainAbout = "${baseUrl}about_app.php";
 String departments = "${baseUrl}office_department_app.php";
  Future<List<SlideShowImage>> getSlideShowPhotos(String? type) async {
    List<SlideShowImage> list = [];
    Response response;
    response = await Dio().get(
      slideShow+"?school_type=$type",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(SlideShowImage.fromJson(element));
      });
    }
    return list;
  }
  Future<List<SlideShowImage>>? getMainSlideShowPhotos() async {
    List<SlideShowImage> list = [];
    Response response;
    response = await Dio().get(

      mainSlideShow,
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(SlideShowImage.fromJson(element));
      });
    }
    return list;

  }
  Future<List<DepartmentModel>> getDepartmentData() async {
    List<DepartmentModel> list = [];
    Response response;
    response = await Dio().get(

     departments,
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(DepartmentModel.fromJson(element));
      });
    }
    return list;
  }
  Future<MainAboutModel> getMainAbout() async {
    MainAboutModel list = MainAboutModel();
    Response response;
    response = await Dio().get(
      mainAbout,
    );
    list = MainAboutModel.fromJson(response.data[0]);
    return list;
  }

}
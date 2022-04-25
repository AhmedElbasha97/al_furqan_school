// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/AppInfo/News.dart';
import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/models/AppInfo/newsDetails.dart';
import 'package:al_furqan_school/models/AppInfo/sliderPhotos.dart';
import 'package:al_furqan_school/models/AppInfo/subject.dart';
import 'package:al_furqan_school/models/AppInfo/subjectDetails.dart';
import 'package:dio/dio.dart';

class AppInfoService {
  String baseURL = "https://alforqanschools.sch.qa/site/api/";
  String sliderLink = "${baseUrl}slide.php";
  String aboutSchool = "about.php";
  String schoolWord = "school_desc.php";
  String aboutApp = "${baseUrl}about_app.php";
  String privacyPolicy = "${baseUrl}privacy.php";
  String subjects = "${baseUrl}subjects.php";
  String subjectsDetails = "${baseUrl}art.php";
  String news = "${baseUrl}news.php";
  String newsDetails = "${baseUrl}news_view.php";

  Future<List<SliderData>> getSliderPhotos() async {
    List<SliderData> list = [];
    Response response;
    response = await Dio().get(
      sliderLink,
    );
    var data = response.data;
    data.forEach((element) {
      list.add(SliderData.fromJson(element));
    });
    return list;
  }

  Future<AboutSchool> getAboutSchool() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      baseURL + aboutSchool,
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getSchoolWord() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      baseURL+schoolWord,
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getaboutApp() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
     aboutApp,
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getPrivacyPolicy() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      privacyPolicy,
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<List<Subjects>> getSubjects() async {
    List<Subjects> list = [];
    Response response;
    response = await Dio().get(
      subjects,
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Subjects.fromJson(element));
    });
    return list;
  }

  Future<List<SubjectDetails>> getSubjectDetails({String? id}) async {
    List<SubjectDetails> list = [];
    Response response;
    response = await Dio().get(
      "$subjectsDetails?dep_id=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(SubjectDetails.fromJson(element));
    });
    return list;
  }

  Future<List<News>> getNews() async {
    List<News> list = [];
    Response response;
    response = await Dio().get(
      news,
    );
    var data = response.data;
    data.forEach((element) {
      list.add(News.fromJson(element));
    });
    return list;
  }

  Future<List<NewsDetails>> getNewsDetails({String? id}) async {
    List<NewsDetails> list = [];
    Response response;
    response = await Dio().get(
      "$newsDetails?news_id=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(NewsDetails.fromJson(element));
    });
    return list;
  }
}

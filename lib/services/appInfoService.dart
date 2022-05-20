// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/models/AppInfo/sliderPhotos.dart';
import 'package:al_furqan_school/models/AppInfo/subject.dart';
import 'package:al_furqan_school/models/AppInfo/subjectDetails.dart';
import 'package:al_furqan_school/models/new/news.dart';
import 'package:al_furqan_school/models/new/news_details.dart';
import 'package:al_furqan_school/models/new/social_link.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfoService {

  String sliderLink = "${baseUrl}slide.php";
  String aboutSchool = "${baseUrl}about.php";
  String terms="${baseUrl}agreament.php";
  String schoolWord = "${baseUrl}school_desc.php";
  String aboutApp = "${baseUrl}about_app.php";
  String privacyPolicy = "${baseUrl}privacy.php";
  String socialLinks="${baseUrl}social.php";
  String subjects = "${baseUrl}subjects.php";
  String subjectsDetails = "${baseUrl}art.php";
  String news = "${baseUrl}news.php?";
  String newsDetails = "${baseUrl}news_view.php?";

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
      aboutSchool,
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getSchoolWord() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      schoolWord,
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
  Future<AboutSchool> getTermsAndCondition() async {
    AboutSchool data;
    Response response;

    response = await Dio().get(
      terms,
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
  Future<SocialLinkModel> gatSocialLink() async {
    SocialLinkModel data;
    Response response;

    response = await Dio().get(
      socialLinks,
    );
    var resData = response.data;
    data = SocialLinkModel.fromJson(resData[0]);
    return data;
  }
  Future<List<NewsModel>> getNewsData(schoolType) async {
    List<NewsModel> list =[];
    Response response;

    response = await Dio().get(
      news+"school_type=$schoolType",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(NewsModel.fromJson(element));
    });

    return list;
  }
  Future<NewsDetailsModel> getNewsDetailsData(String id) async {
    NewsDetailsModel data;
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolType = prefs.getString("schoolType");
    response = await Dio().get(
      newsDetails+"school_type=$schoolType&news_id=$id",
    );
    var resData = response.data;
    data = NewsDetailsModel.fromJson(resData[0]);
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


}

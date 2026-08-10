// ignore_for_file: file_names
import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/models/AppInfo/sliderPhotos.dart';
import 'package:al_furqan_school/models/AppInfo/subject.dart';
import 'package:al_furqan_school/models/AppInfo/subjectDetails.dart';
import 'package:al_furqan_school/models/new/news.dart';
import 'package:al_furqan_school/models/new/news_details.dart';
import 'package:al_furqan_school/models/new/social_link.dart';
import 'package:al_furqan_school/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfoService {
  Future<List<SliderData>> getSliderPhotos() async {
    try {
      final response = await ApiClient.instance.dio.get('slide.php');
      if (response.data != null) {
        return (response.data as List)
            .map((e) => SliderData.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<AboutSchool?> getAboutSchool() async {
    try {
      final response = await ApiClient.instance.dio.get('about.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return AboutSchool.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<AboutSchool?> getSchoolWord() async {
    try {
      final response = await ApiClient.instance.dio.get('school_desc.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return AboutSchool.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<AboutSchool?> getaboutApp() async {
    try {
      final response = await ApiClient.instance.dio.get('about_app.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return AboutSchool.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<AboutSchool?> getTermsAndCondition() async {
    try {
      final response = await ApiClient.instance.dio.get('agreament.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return AboutSchool.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<AboutSchool?> getPrivacyPolicy() async {
    try {
      final response = await ApiClient.instance.dio.get('privacy.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return AboutSchool.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<SocialLinkModel?> gatSocialLink() async {
    try {
      final response = await ApiClient.instance.dio.get('social.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return SocialLinkModel.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<List<NewsModel>> getNewsData(dynamic schoolType) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'news.php',
        queryParameters: {'school_type': schoolType},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => NewsModel.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<NewsDetailsModel?> getNewsDetailsData(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final schoolType = prefs.getString('schoolType');
      final response = await ApiClient.instance.dio.get(
        'news_view.php',
        queryParameters: {'school_type': schoolType, 'news_id': id},
      );
      if (response.data != null && (response.data as List).isNotEmpty) {
        return NewsDetailsModel.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<List<Subjects>> getSubjects() async {
    try {
      final response = await ApiClient.instance.dio.get('subjects.php');
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Subjects.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<SubjectDetails>> getSubjectDetails({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'art.php',
        queryParameters: {'dep_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => SubjectDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }
}

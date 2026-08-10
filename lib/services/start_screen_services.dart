import 'package:al_furqan_school/models/new/department_model.dart';
import 'package:al_furqan_school/models/new/main_about_model.dart';
import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:al_furqan_school/services/api_client.dart';

class StarScreenServices {
  Future<List<SlideShowImage>> getSlideShowPhotos(String? type) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'slide.php',
        queryParameters: {'school_type': type},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => SlideShowImage.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<SlideShowImage>> getMainSlideShowPhotos() async {
    try {
      final response = await ApiClient.instance.dio.get('slide_app.php');
      if (response.data != null) {
        return (response.data as List)
            .map((e) => SlideShowImage.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<DepartmentModel>> getDepartmentData() async {
    try {
      final response =
          await ApiClient.instance.dio.get('office_department_app.php');
      if (response.data != null) {
        return (response.data as List)
            .map((e) => DepartmentModel.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<MainAboutModel?> getMainAbout() async {
    try {
      final response = await ApiClient.instance.dio.get('about_app.php');
      if (response.data != null && (response.data as List).isNotEmpty) {
        return MainAboutModel.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }
}
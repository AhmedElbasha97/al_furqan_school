import 'package:al_furqan_school/models/new/departmen_detail_model.dart';
import 'package:al_furqan_school/services/api_client.dart';

class DepartmentServices {
  Future<DepartmentDataModel?> getDepartmentData(String? id) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'office_department_app_articles.php',
        queryParameters: {'dep_id': id},
      );
      if (response.data != null && (response.data as List).isNotEmpty) {
        return DepartmentDataModel.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }
}

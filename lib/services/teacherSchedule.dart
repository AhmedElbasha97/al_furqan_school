// ignore_for_file: file_names
import 'package:al_furqan_school/models/schedule.dart';
import 'package:al_furqan_school/services/api_client.dart';

class TeacherScheduleService {
  Future<List<Schedule>> getSchedule({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'teacher_table.php',
        queryParameters: {'teacher_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Schedule.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }
}

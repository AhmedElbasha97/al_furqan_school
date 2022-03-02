// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/schedule.dart';
import 'package:dio/dio.dart';

class TeacherScheduleService {
  String schedule = "${baseUrl}teacher_table.php";

  Future<List<Schedule>> getSchedule({String? id}) async {
    List<Schedule> list = [];
    Response response;
    response = await Dio().get(
      "$schedule?teacher_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Schedule.fromJson(element));
      });
    }
    return list;
  }
}

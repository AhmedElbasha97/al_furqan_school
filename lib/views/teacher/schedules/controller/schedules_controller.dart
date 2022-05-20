import 'package:al_furqan_school/models/schedule.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teacherSchedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulesController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  List<Schedule> schedule = [];
  final BuildContext context;
  SchedulesController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    schedule = await TeacherScheduleService().getSchedule(id: id);
    if(schedule.isEmpty){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
    update();
  }
}
import 'package:al_furqan_school/models/parents/attendance.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController{
  bool isLoading = true;
  List<Attendance> attendance = [];
  String? studentID= Get.arguments[0];
  bool hasNoData = false;
  final BuildContext context;
  AttendanceController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    isLoading = true;
    update();
    if(studentID!=null){
      attendance = await ParentService().getAttendance(id: studentID);
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("id");
      attendance = await ParentService().getAttendance(id: id);
    }
    if(attendance.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }
}
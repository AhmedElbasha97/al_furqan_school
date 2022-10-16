import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/parents/attendance.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController{
  bool isLoading = true;
  bool isOffline = false;

  List<Attendance> attendance = [];
  String? studentID;
  bool hasNoData = false;
  final BuildContext context;
  AttendanceController(this.context);
  @override
  Future<void> onInit() async {
    if(Get.arguments!=null) {
      studentID = Get.arguments[0];
    }
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }

    super.onInit();
  update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
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
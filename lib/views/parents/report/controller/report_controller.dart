import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/parents/reports.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportController extends GetxController{
  bool isLoading = true;
  List<Report> reports = [];
  bool hasNoData = true;
  bool isOffline = false;

  String? studentID;
  final BuildContext context;
  ReportController(this.context);
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
    NotificationServices.checkNotificationAppInForeground(context);
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
      reports = await ParentService().getReports(id: studentID);
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("id");
      reports = await ParentService().getReports(id: id);
    }

    if(reports.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }
}
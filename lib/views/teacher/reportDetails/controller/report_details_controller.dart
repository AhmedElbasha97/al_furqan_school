import 'package:al_furqan_school/models/teacher/reportDetails.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportDetailsController extends GetxController{
  bool isLoading = true;
  List<TeacherReportDetails> reports = [];
  String reportId=Get.arguments[0];
  bool hasNoData = false;
  final BuildContext context;
  ReportDetailsController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    reports =
    await TeacherService().getReportDetails(id: id, reportId: reportId);
    if(reports[0].text==""){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }

}
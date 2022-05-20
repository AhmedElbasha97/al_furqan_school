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
  final BuildContext context;
  ReportController(this.context);
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
    reports = await ParentService().getReports(id: id);
    if(reports.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }
}
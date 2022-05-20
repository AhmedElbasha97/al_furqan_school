import 'package:al_furqan_school/models/AppInfo/subject.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  List<Subjects> subjects = [];
  final BuildContext context;
  SubjectController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    isLoading = true;
    update();
    subjects = await AppInfoService().getSubjects();
    if(subjects.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }
}
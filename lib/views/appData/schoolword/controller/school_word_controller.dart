import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolWordController extends GetxController{
  late AboutSchool word;
  bool isAbout = Get.arguments[0];
  bool loading = true;

  final BuildContext context;
  @override
  SchoolWordController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    word = isAbout
        ? await AppInfoService().getAboutSchool()
        : await AppInfoService().getSchoolWord();
    loading = false;
    update();
  }
}
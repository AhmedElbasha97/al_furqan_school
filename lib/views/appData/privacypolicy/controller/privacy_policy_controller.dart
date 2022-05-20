import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController{
  late AboutSchool word;
  bool loading = true;

  final BuildContext context;
  @override
  PrivacyPolicyController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    word = await AppInfoService().getPrivacyPolicy();
    loading = false;
    update();
  }
}
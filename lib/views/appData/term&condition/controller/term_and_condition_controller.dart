import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionController extends GetxController{
  late AboutSchool word;
  bool loading = true;
  final BuildContext context;
  @override
  TermsAndConditionController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getData() async {
    word = await AppInfoService().getTermsAndCondition();
    loading = false;
    update();
  }
}
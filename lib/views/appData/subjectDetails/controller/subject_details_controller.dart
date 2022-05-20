import 'package:al_furqan_school/models/AppInfo/subjectDetails.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectDetailsController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  List<SubjectDetails> details = [];
  var subjID = Get.arguments[0];

  final BuildContext context;
  SubjectDetailsController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    details = await AppInfoService().getSubjectDetails(id:subjID);
    if(details[0].description==null){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
    update();
  }
}
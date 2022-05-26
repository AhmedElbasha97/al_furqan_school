import 'package:al_furqan_school/models/new/student_info_model.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentInfoController extends GetxController{
  StudentInfoModel? student;
  bool isLoading =true;
  String studentId= Get.arguments[0];
  final BuildContext context;
  StudentInfoController(this.context);
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
getData()async{
    student = await ParentService().getStudentInfo(id: studentId);
    isLoading = false;
    update();
}

}
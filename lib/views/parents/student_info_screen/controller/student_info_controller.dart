import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/student_info_model.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentInfoController extends GetxController{
  StudentInfoModel? student;
  bool isLoading =true;
  bool isOffline = false;

  String studentId= Get.arguments[0];
  final BuildContext context;
  StudentInfoController(this.context);
  @override
  Future<void> onInit() async {
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
getData()async{
    student = await ParentService().getStudentInfo(id: studentId);
    isLoading = false;
    update();
}

}
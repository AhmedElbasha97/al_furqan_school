import 'package:al_furqan_school/models/new/student_list_model.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListController extends GetxController{
StudentListModel? studentList;
bool isLoading =true;
final BuildContext context;
StudentListController(this.context);
@override
Future<void> onInit() async {
  await getData();
  super.onInit();
  NotificationServices.checkNotificationAppInForeground(context);
}
getData() async {
   isLoading =true;
  update();
  studentList=await ParentService().getStudentList();
   isLoading = false;
   update();
}

}
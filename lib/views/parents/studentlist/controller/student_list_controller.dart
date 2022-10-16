import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/student_list_model.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListController extends GetxController{
StudentListModel? studentList;
bool isLoading =true;
final BuildContext context;
bool isOffline = false;

StudentListController(this.context);
@override
Future<void> onInit() async {
  isOffline = !await connectivityChecker();
  if(!isOffline){
    await getData();
  }  super.onInit();
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
getData() async {
   isLoading =true;
  update();
  studentList=await ParentService().getStudentList();
   isLoading = false;
   update();
}

}
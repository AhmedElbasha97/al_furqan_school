import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/schedule.dart';
import 'package:al_furqan_school/services/teacherSchedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulesController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  bool isOffline = false;

  List<Schedule> schedule = [];
  final BuildContext context;
  SchedulesController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    super.onInit();
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
   bool hasAnyScheduleThisDay(index){
    if(schedule[index].class1!=""&&schedule[index].class2!=""&&schedule[index].class3!=""&&schedule[index].class4!=""&&schedule[index].class5!=""&&schedule[index].class6!=""&&schedule[index].class7!=""&&schedule[index].class8!=""){
      return false;
    }else{
      return true;
    }
   }
  getData() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    schedule = await TeacherScheduleService().getSchedule(id: id);
    if(schedule.isEmpty){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
    update();
  }
}
import 'package:al_furqan_school/models/teacher/homeWork.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWorkController extends GetxController{
  bool isLoading = true;
  List<HomeWorkTeacher> homeworks = [];
  bool hasNoData= false;

  final BuildContext context;
  HomeWorkController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    homeworks = await TeacherService().getHomeWork(id: id);
    if(homeworks.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
   update();
  }}
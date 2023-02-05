import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchoolWordController extends GetxController{
  late AboutSchool word;
  bool isAbout = Get.arguments[0];
  bool loading = true;
  bool isOffline = false;

  final BuildContext context;
  @override
  SchoolWordController(this.context);
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

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolType =  prefs.getString("schoolType");
    word = isAbout
        ? await AppInfoService().getAboutSchool(schoolType ?? "")
        : await AppInfoService().getSchoolWord(schoolType ?? "");
    loading = false;
    update();
  }
}
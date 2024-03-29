import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionController extends GetxController{
  late AboutSchool word;
  bool loading = true;
  bool isOffline = false;

  final BuildContext context;
  @override
  TermsAndConditionController(this.context);
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
    word = await AppInfoService().getTermsAndCondition();
    loading = false;
    update();
  }
}
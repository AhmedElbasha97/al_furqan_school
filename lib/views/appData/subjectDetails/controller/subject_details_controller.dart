import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/subjectDetails.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectDetailsController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  List<SubjectDetails>? details = [];
  var subjID = Get.arguments[0];
  bool isOffline = false;

  final BuildContext context;
  SubjectDetailsController(this.context);
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
    details = await AppInfoService().getSubjectDetails(id:subjID);
    if(details==null||(details![0].brief==null)&&(details![0].file=="")&&(details![0].title==null)){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
    update();
  }
}
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/departmen_detail_model.dart';
import 'package:al_furqan_school/services/sevices_derpartment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheDepartmentController extends GetxController{
  var departmentId= Get.arguments;
  DepartmentDataModel? department;
  var hasNoData = false;
  bool isOffline = false;
  var isLoading = true;
  int currentIndex = 0;
  DepartmentServices departmentServices = DepartmentServices();

  final BuildContext context;
  TheDepartmentController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getPhotoSliderData();
    }
    super.onInit();
  update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getPhotoSliderData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
    update();
  }
  updateCurrentIndex(int index){
    currentIndex = index;
    update();
  }
  getPhotoSliderData() async {
    department = await departmentServices.getDepartmentData(departmentId[0]);
    print(department!.brief??"");
    if(department == null){
      hasNoData =true;
    }
    isLoading = false;
    update();
  }
}
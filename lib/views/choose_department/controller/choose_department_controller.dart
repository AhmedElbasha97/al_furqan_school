// ignore_for_file: use_build_context_synchronously

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/department_model.dart';
import 'package:al_furqan_school/services/start_screen_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseDepartmentController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  List<DepartmentModel> departmentData =[];
  bool isOffline = false;
  StarScreenServices startScreenServices = StarScreenServices();

  final BuildContext context;
  ChooseDepartmentController(this.context);
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
    isLoading = true;
      departmentData = await startScreenServices.getDepartmentData();
      if(departmentData.isEmpty){
        hasNoData=true;
      }
    isLoading = false;
    update();
  }
}
import 'package:al_furqan_school/models/new/departmen_detail_model.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/sevices_derpartment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheDepartmentController extends GetxController{
  var departmentId= Get.arguments;
  DepartmentDataModel? department;
  var hasNoData = false;
  var isLoading = true;
  DepartmentServices departmentServices = DepartmentServices();

  final BuildContext context;
  TheDepartmentController(this.context);
  @override
  void onInit() {
    getPhotoSliderData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getPhotoSliderData() async {
    department = await departmentServices.getDepartmentData(departmentId[0]);
    if(department == null){
      hasNoData =true;
    }
    isLoading = false;
    update();
  }
}
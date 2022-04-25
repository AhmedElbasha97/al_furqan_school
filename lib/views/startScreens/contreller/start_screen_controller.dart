import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:al_furqan_school/services/start_screen_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends GetxController{
  @override
  List<Widget?>? child;
  var isLoading=true;
  StarScreenServices startScreenServices = StarScreenServices();
  String? selectedType = "اختار نوع المستخدم";
  late List<SlideShowImage> imageData;
  void onInit() {
    getPhotoSliderData();
    super.onInit();
  }
getPhotoSliderData() async {
imageData = await startScreenServices.getSlideShowPhotos();
isLoading = false;
update();
}

}
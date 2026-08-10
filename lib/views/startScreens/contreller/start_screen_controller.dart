import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/department_model.dart';
import 'package:al_furqan_school/models/new/main_about_model.dart';
import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:al_furqan_school/services/start_screen_services.dart';
import 'package:al_furqan_school/views/homescreen/homeScreen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends GetxController{
  var isLoading=true;

  CarouselSliderController carouselController = CarouselSliderController();
  int current =0;
  bool isOffline = false;
  StarScreenServices startScreenServices = StarScreenServices();
  String? selectedType = "اختار نوع المستخدم";
  MainAboutModel? about ;
   List<DepartmentModel> departmentData =[];
  late List<SlideShowImage> imageData;
  final BuildContext context;
  StartScreen(this.context);
  @override
  Future<void> onInit() async {
    checkForUpgrades();

    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getPhotoSliderData();
    }
    super.onInit();
    update();
  }
  Future<void> refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){

      await getPhotoSliderData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  void checkForUpgrades() {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }
  Future<void> chooseSchool(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    switch(index){
      case 0:{
        prefs.setString("schoolType", "j");
      }
      break;
      case 1:{
        prefs.setString("schoolType", "p");
      }
      break;
      case 3:{
        prefs.setString("schoolType", "s");
      }
      break;
    }

    Get.to(() =>const HomeScreen(),
    );
  }
  void carouseChangeIndex(int index, dynamic reason){
    current = index;
    update();
  }
Future<void> getPhotoSliderData() async {
imageData = await startScreenServices.getMainSlideShowPhotos();
getMainAbout();
getDepartments();
isLoading = false;
update();
}
Future<void> getMainAbout() async {
about = await startScreenServices.getMainAbout();
}
Future<void> getDepartments() async {
   departmentData = await startScreenServices.getDepartmentData();
}
}
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/department_model.dart';
import 'package:al_furqan_school/models/new/main_about_model.dart';
import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/start_screen_services.dart';
import 'package:al_furqan_school/views/homescreen/homeScreen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends GetxController{
  var isLoading=true;

  final CarouselController carosuelController = CarouselController();
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
    NewVersion(

      androidId: "com.sync.al_furqan_school",
      iOSId: "com.sync.alFurqanSchool",
    ).showAlertIfNecessary(context: context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("schoolType")){
      prefs.remove("schoolType");
    }

    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getPhotoSliderData();
    }
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
    update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){

      await getPhotoSliderData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  chooseSchool(int index) async {
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
  carouseChangeIndex(index,reason){
    current = index;
    update();
  }
getPhotoSliderData() async {
imageData = await startScreenServices.getMainSlideShowPhotos();
getMainAbout();
getDepartments();
isLoading = false;
update();
}
getMainAbout()async{
about = await startScreenServices.getMainAbout();
}
getDepartments() async {
   departmentData = await startScreenServices.getDepartmentData();
}
}
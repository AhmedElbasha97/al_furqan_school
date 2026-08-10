import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/news.dart';
import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/start_screen_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../globals/helpers.dart';
import '../../loggedUser/Messages/messageScreen/MessagesScreen.dart';
import '../../loggedUser/homework/homeWork.dart';
import '../../loggedUser/quetion_bank/questionBank.dart';
import '../../startScreens/choose_state_screen.dart';
import '../../teacher/messages/massagescreen/MessagesScreen.dart';

class HomeScreenController extends GetxController{
  List<SlideShowImage> sliderData = [];
  List<Gallery> list = [];
  late String homeWorkId;
  List<Videos> list2 = [];
  StarScreenServices startScreenServices = StarScreenServices();
  bool slideShowLoading = true;
  bool videosShowLoading = true;
  bool isOffline = false;

  bool galleryShowLoading = true;
  bool newsShowLoading = true;
  bool hasNoData=false;
  List<NewsModel>? news = [];
  final BuildContext context;
  HomeScreenController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getHomeData();
      await getAlbumsData();
      await getVideoData();
      await getData();
    }
    super.onInit();

  update();
  }
  Future<void> decideIfThereIsNotificationDetectOrNotAndItIsBehavior() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString("type");
    String? screenType = prefs.getString("route");

    debugPrint('userType: ${userType ?? ""}');
    debugPrint('screenType: ${screenType ?? ""}');

    if (screenType == null) return;
    switch(screenType){
      case "teacher_msg ":
        {

          Get.to(()=> const MessagesScreenTeacher());

        }
        break;
      case "parent_msg ":{
        Get.to(()=> const MessagesScreen(),arguments: [0]);
      }
      break;
      case "student_msg":{
        Get.to(()=> const MessagesScreen(),arguments: [1]);

      }
      break;
      case "student_homework ":{
        Get.to(()=> const HomeWorkScreen());
      }
      break;
      case "student_quest ":{
        Get.to(()=> const QuestionBankScreen());
      }
      break;  case "parent_quest ":{
      Get.to(()=> const QuestionBankScreen());

    }
    break;  case "student_report ":{
      Get.to(()=> const HomeWorkScreen());

    }
    break;
      default:
        {
          Get.to(()=> const ChooseStateScreen());

          break;
        }
    }
  }
  Future<void> refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  Future<void> getHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    homeWorkId = prefs.getString("schoolType")??"";
    sliderData = await startScreenServices.getSlideShowPhotos(homeWorkId);
    slideShowLoading = false;
   update();
  }
  Future<void> getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolType =  prefs.getString("schoolType");
    news = await AppInfoService().getNewsData(schoolType);
    newsShowLoading=false;
  update();

  }
  Future<void> launchURL(BuildContext context, dynamic link) async {
    if ( await launchUrl(Uri.parse(link??""))) {

      showTheDialog(context, "لايمكن عرض الفيديو", "ليس متوفر فيديو");
      throw 'Could not launch $link';

    }
  }

  Future<void> getAlbumsData() async {
    list = await AlbumsService().getPhotoAlbums();
  galleryShowLoading=false;
  update();

  }
  Future<void> getVideoData() async {
    list2 = await AlbumsService().getVideoAlbums();
    videosShowLoading=false;
    update();

  }


}
import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/news.dart';
import 'package:al_furqan_school/models/new/slide_show_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/start_screen_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../globals/helpers.dart';

class HomeScreenController extends GetxController{
  List<SlideShowImage> sliderData = [];
  List<Gallery> list = [];
  late String homeWorkId;
  List<Videos> list2 = [];
  StarScreenServices startScreenServices = StarScreenServices();
  bool slideShowLoading = true;
  bool videosShowLoading = true;
  bool galleryShowLoading = true;
  bool newsShowLoading = true;
  bool hasNoData=false;
  List<NewsModel>? news = [];
  final BuildContext context;
  HomeScreenController(this.context);
  @override
  Future<void> onInit() async {
    await getHomeData();
    await getAlbumsData();
    await getVideoData();
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    homeWorkId = prefs.getString("schoolType")??"";
    sliderData = await startScreenServices.getSlideShowPhotos(homeWorkId);
    slideShowLoading = false;
   update();
  }
  getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolType =  prefs.getString("schoolType");
    news = await AppInfoService().getNewsData(schoolType);
    newsShowLoading=false;
  update();

  }
  launchURL(context,link) async {
    if (await canLaunchUrl(Uri.parse(link??""))) {
      await launchUrl(Uri.parse(link??""));
    } else {
      showTheDialog(context, "لايمكن عرض الفيديو", "ليس متوفر فيديو");
      throw 'Could not launch $link';

    }
  }

  getAlbumsData() async {
    list = await AlbumsService().getPhotoAlbums();
  galleryShowLoading=false;
  update();

  }
  getVideoData() async {
    list2 = await AlbumsService().getVideoAlbums();
    videosShowLoading=false;
    update();

  }


}

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/photo.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PhotosAlbumsController extends GetxController{
  bool isLoading = true;
  List<Photo> list = [];
  String photoId =Get.arguments[0];
  String title = Get.arguments[1];
  bool hasNoData = false;
  bool isOffline = false;

  final BuildContext context;
  PhotosAlbumsController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
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
    update();
      list = await AlbumsService().getPhotoAlbum(photoId);
    isLoading = false;
  update();
  }


}
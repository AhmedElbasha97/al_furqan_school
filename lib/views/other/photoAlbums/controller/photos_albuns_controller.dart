
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
  final BuildContext context;
  PhotosAlbumsController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getData() async {
    isLoading = true;
    update();
      list = await AlbumsService().getPhotoAlbum(photoId);
    isLoading = false;
  update();
  }


}
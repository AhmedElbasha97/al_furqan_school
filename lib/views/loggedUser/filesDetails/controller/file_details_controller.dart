import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/FilesDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesDetailsScreen extends GetxController{
  bool isLoading = true;
  List<FileDetails> files = [];
  var fileID= Get.arguments;
  final BuildContext context;
  FilesDetailsScreen(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    files = await LoggedUser().getFilesDetails(id: id, fileID: fileID ?? "");
    isLoading = false;
    update();
  }
  hasFileLink(index){
    return files[index].fileLink != null;
  }
  hasFileData(index){
    return files[index].fileDet != null;
  }
  launchURL(context, index) async {
    if (await canLaunchUrl(Uri.parse(files[index].fileLink??""))) {
      await launchUrl(Uri.parse(files[index].fileLink??""));
    } else {
      showTheDialog(context, "لا يمكن تحميل هذا الملف", "لا يوجد ملف متاح للتحميل ");
      throw 'Could not launch ${files[index].fileLink}';

    }
  }
}
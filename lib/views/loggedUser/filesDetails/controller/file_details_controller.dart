import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/FilesDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesDetailsScreen extends GetxController{
  bool isLoading = true;
  bool isOffline = false;
  List<FileDetails> files = [];
  var fileID= Get.arguments;
  final BuildContext context;
  FilesDetailsScreen(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    super.onInit();
  update();
  }
  Future<void> refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    files = await LoggedUser().getFilesDetails(id: id, fileID: fileID ?? "");
    isLoading = false;
    update();
  }
  bool hasFileLink(int index){
    return files[index].fileLink != null;
  }
  bool hasFileData(int index){
    return files[index].fileDet != null;
  }
  Future<void> launchURL(BuildContext context, int index) async {
    if (await launchUrl(Uri.parse(files[index].fileLink??""))) {
      showTheDialog(context, "لا يمكن تحميل هذا الملف", "لا يوجد ملف متاح للتحميل ");
      throw 'Could not launch ${files[index].fileLink}';

    }
  }
}
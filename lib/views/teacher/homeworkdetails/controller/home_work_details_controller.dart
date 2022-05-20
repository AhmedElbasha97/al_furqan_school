import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teacher/HomeWorkDetails.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWorkDetailsController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  var homeWorkId= Get.arguments[0];
  List<HomeWorkDetailsTeacherModel> homework = [];
  final BuildContext context;
  HomeWorkDetailsController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  launchURL(context, index) async {
    if (await canLaunchUrl(Uri.parse(homework[index].homeworkFile??""))) {
      await launchUrl(Uri.parse(homework[index].homeworkFile??""));
    } else {
      showTheDialog(context, "لا يمكن تحميل هذا الملف", "لا يوجد ملف متاح للتحميل ");
      throw 'Could not launch ${homework[index].homeworkFile}';

    }
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    homework = await TeacherService()
        .getHomeworkDetails(id: id, homeworkId: homeWorkId);
    if(homework[0].homeworkDet==""){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
update();
  }
}
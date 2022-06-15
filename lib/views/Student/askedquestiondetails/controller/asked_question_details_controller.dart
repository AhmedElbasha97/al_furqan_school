import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/Student/AskedQuestionDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskedQuestionDetailsController extends GetxController{
  bool isLoading = true;
  List<AskedQuestionDetails> details = [];
  var qesID=Get.arguments[0];
  bool hasNoData = false;
  bool isOffline = false;

  final BuildContext context;
  AskedQuestionDetailsController(this.context);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    details = await LoggedUser()
        .getAskedQuestionsDetails(id: id, qid:qesID ?? "");
    isLoading = false;
   update();
  }

}
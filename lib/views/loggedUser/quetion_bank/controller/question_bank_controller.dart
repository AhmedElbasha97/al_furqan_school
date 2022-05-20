import 'package:al_furqan_school/models/question.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionBankController extends GetxController{
  bool isLoading = true;
  List<Question> questions = [];
  bool hasNoData =false;
  final BuildContext context;
  QuestionBankController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }
  getData() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    questions = await LoggedUser().getQuestions(id: id);
    if(questions.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }
}
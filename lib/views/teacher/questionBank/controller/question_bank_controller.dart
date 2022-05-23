import 'package:al_furqan_school/models/teacher/questionBank.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionBankController extends GetxController{
  bool isLoading = true;
  List<QuestionBankTeacher> questions = [];
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
    questions = await TeacherService().getQuestionBank(id: id);
    isLoading = false;
    update();
  }
}
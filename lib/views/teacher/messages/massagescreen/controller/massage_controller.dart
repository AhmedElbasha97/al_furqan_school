import 'package:al_furqan_school/models/teacher/sentMessages.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageController extends GetxController{
  bool isLoading = true;
  List<SentMessagesTeacher> messages = [];
  bool hasNoData=false;
  final BuildContext context;
  MessageController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    isLoading = false;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    messages = await TeacherService().getSentMessages(
      id: id,
    );
    if(messages.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
    update();
  }

}
import 'package:al_furqan_school/models/MessageSentStudent.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentMessageController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  List<MessageSentStudent> messages = [];
  var type =Get.arguments[0];
  final BuildContext context;
  SentMessageController(this.context);
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
    messages = type != 1
        ? await ParentService().getSentMessages(
      id: id,
    )
        : await MessagesService().getSentMessages(
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
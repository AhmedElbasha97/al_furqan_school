import 'package:al_furqan_school/models/messageDetails.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsController extends GetxController{
  bool isLoading = true;
  List<MessageDetails> msg = [];
  var idmsg =Get.arguments[1];
  bool hasNoData=false;
  var type =Get.arguments[0];
  final BuildContext context;
  MessageDetailsController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    msg = type != 1
        ? await ParentService().getMessageDetails(id: id, msgId: idmsg)
        : await MessagesService().getMessageDetails(id: id, msgId: idmsg);
    if(msg[0].text==""){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
    update();
  }
}
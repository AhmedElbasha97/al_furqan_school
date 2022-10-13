import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/messageDetails.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsController extends GetxController{
  bool isLoading = true;
  List<MessageDetails> msg = [];
  var idmsg =Get.arguments[1];
  bool hasNoData=false;
  var type =Get.arguments[0];
  bool isOffline = false;

  final BuildContext context;
  MessageDetailsController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    super.onInit();
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
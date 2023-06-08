// ignore_for_file: use_build_context_synchronously

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/message.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreenController extends GetxController{
  bool isLoading = true;
  bool isOffline = false;
  bool hasNoData=false;
  var type= Get.arguments[0];
  List<Messages> messages = [];
  final BuildContext context;
  MessageScreenController(this.context);
  Future<void> onDetached() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
  }
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
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    messages = type != 1
        ? await ParentService().getMessages(
      id: id,
    )
        : await MessagesService().getMessages(
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
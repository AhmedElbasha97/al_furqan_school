import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teacher/sentMessages.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageController extends GetxController{
  bool isLoading = true;
  bool isOffline = false;
  List<SentMessagesTeacher> messages = [];
  bool hasNoData=false;
  final BuildContext context;
  MessageController(this.context);
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
import 'package:al_furqan_school/models/teacher/messagedetails.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsController extends GetxController{
  var idmsg =Get.arguments[0];
  bool hasNoData=false;
  bool isLoading = true;
  List<MessageDetailsTeacherModel> msg = [];
  final BuildContext context;
  MessageDetailsController(this.context);
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
    msg =
    await TeacherService().getsentMessageDetails(id: id, msgId:idmsg);
    // if(msg[0].text==""){
    //   hasNoData=true;
    // }else{
    //   hasNoData=false;
    // }
    isLoading = false;
    update();
  }

}
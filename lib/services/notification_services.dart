import 'dart:io';

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/notification.dart';
import 'package:al_furqan_school/views/loggedUser/homework/homeWork.dart';
import 'package:al_furqan_school/views/loggedUser/quetion_bank/questionBank.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';



class NotificationServices{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
 final notification = "notifications";
 static var  context;



  static checkNotificationAppInBackground(context) async{
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        String? data;
        message.data.forEach((key, value) {
          if (key == "data"){
            data=notificationFromJson(value).route;
          }
        });
        notificationSelectingAction(data, context);
      }
    });
  }
  static checkNotificationAppInForeground(contextOfScreen) async{
    context = contextOfScreen;
    FirebaseMessaging.onMessage.listen((message) {
      print("notification data");
      print(message.data);
      NotificationServices.display(message);
    });
  }
  static launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showTheDialog(context, "لا يمكن تحميل هذا الملف", "لا يوجد ملف متاح للتحميل ");
      throw 'Could not launch $url';

    }
  }
  static void initialize(){
    const InitializationSettings _initializationSettings = InitializationSettings(android: AndroidInitializationSettings(
        "@mipmap/ic_launcher"
    ),iOS: IOSInitializationSettings());
    _notificationsPlugin.initialize(_initializationSettings,onSelectNotification: (String? route) async{
      if(route != null){
        notificationSelectingAction(route, context);
      }
  });
  }

  static void display(RemoteMessage message)async{
    String? data;
    message.data.forEach((key, value) {
      if (key == "data"){
        data=notificationFromJson(value).route;
      }
    });
    final id = DateTime.now().microsecondsSinceEpoch ~/100000000000000.toInt();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          "high_importance_channel",
        "high_importance_channel high high",
        importance: Importance.max,
        priority: Priority.max,

      ),

    );

    await _notificationsPlugin.show(id, message.notification?.title??"", message.notification?.body??"", notificationDetails,payload: data,);
  }
   static Future<void> notificationSelectingAction(String? route,context) async {
     // SharedPreferences prefs = await SharedPreferences.getInstance();
     //
     // var type= prefs.getString("type");

    switch(route){
      case "teacher_msg ":
        {
          Get.to(()=> const MessagesScreen());
        }
        break;
      case "parent_msg ":{
        Get.to(()=> const MessagesScreen(),arguments: [0]);
      }
      break;  case "student_msg ":{
      Get.to(()=> const MessagesScreen(),arguments: [1]);

    }
      break;  case "student_homework ":{
      pushPage(context, const HomeWorkScreen());
      }
      break;  case "student_quest ":{
      pushPage(context, const QuestionBankScreen());
      }
      break;  case "parent_quest ":{
      pushPage(context, const QuestionBankScreen());

      }
      break;  case "student_report ":{
      pushPage(context, const HomeWorkScreen());

    }
      break;  case "update":{
        launchURL(Platform.isAndroid
            ? "https://play.google.com/store/apps/details?id=com.syncapps.manpower"
            : "https://apps.apple.com/us/app/id1573160692",);
      }
      break;

    }

   }
}
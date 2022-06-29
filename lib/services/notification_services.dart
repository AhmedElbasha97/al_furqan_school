
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/messageScreen/MessagesScreen.dart';
import 'package:al_furqan_school/views/loggedUser/homework/homeWork.dart';
import 'package:al_furqan_school/views/loggedUser/quetion_bank/questionBank.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_icon_badge/flutter_app_icon_badge.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class NotificationServices{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
 final notification = "notifications";
 static var  context;



  static checkNotificationAppInBackground(context) async{
      notificationSelectingAction(context);
  }
  static checkNotificationAppInForeground(contextOfScreen) async{
    context = contextOfScreen;
    FirebaseMessaging.onMessage.listen((message) async {
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
  static Future<void> initialize() async {
    FlutterAppIconBadge.removeBadge();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("counter");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      showBadge: true,
      importance: Importance.max,
    );
    const InitializationSettings _initializationSettings = InitializationSettings(android: AndroidInitializationSettings(
        "@mipmap/ic_launcher",
    ),iOS: IOSInitializationSettings());
    _notificationsPlugin.initialize(_initializationSettings,onSelectNotification: (String? route) async{

        notificationSelectingAction(context);

  });
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void display(RemoteMessage message)async{
    String? data;

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
   static Future<void> notificationSelectingAction(context) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var type= prefs.getString("route");
    switch(type){
      case "teacher_msg ":
        {
          prefs.remove("route");
          Get.to(()=> const MessagesScreenTeacher());

        }
        break;
      case "parent_msg ":{
        prefs.remove("route");
        Get.to(()=> const MessagesScreen(),arguments: [0]);
      }
      break;
      case "student_msg":{
        prefs.remove("route");
      Get.to(()=> const MessagesScreen(),arguments: [1]);

    }
      break;
      case "student_homework ":{
      prefs.remove("route");
      Get.to(()=> const HomeWorkScreen());
      }
      break;
      case "student_quest ":{
      prefs.remove("route");
      Get.to(()=> const QuestionBankScreen());
      }
      break;  case "parent_quest ":{
      prefs.remove("route");
      Get.to(()=> const QuestionBankScreen());

      }
      break;  case "student_report ":{
      prefs.remove("route");
      Get.to(()=> const HomeWorkScreen());

    }
      break;
      default:
      {
        prefs.remove("route");
        Get.to(()=> const ChooseStateScreen());

        break;
      }
    }

   }
}
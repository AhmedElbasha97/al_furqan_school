import 'package:al_furqan_school/views/loggedUser/Messages/messageScreen/MessagesScreen.dart';
import 'package:al_furqan_school/views/loggedUser/homework/homeWork.dart';
import 'package:al_furqan_school/views/loggedUser/quetion_bank/questionBank.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        notificationSelectingAction(message);

    });
    await enableIOSNotifications();
    await registerNotificationListeners();
  }
  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initSetttings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (message) async {
          notificationSelectingAction(message);
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,

              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });
  }
  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  static Future<void> notificationSelectingAction(message) async {

    var type= message.data["type"];
    switch(type){
      case "teacher_msg ":
        {

          Get.to(()=> const MessagesScreenTeacher());

        }
        break;
      case "parent_msg ":{
        Get.to(()=> const MessagesScreen(),arguments: [0]);
      }
      break;
      case "student_msg":{
        Get.to(()=> const MessagesScreen(),arguments: [1]);

      }
      break;
      case "student_homework ":{
        Get.to(()=> const HomeWorkScreen());
      }
      break;
      case "student_quest ":{
        Get.to(()=> const QuestionBankScreen());
      }
      break;  case "parent_quest ":{
      Get.to(()=> const QuestionBankScreen());

    }
    break;  case "student_report ":{
      Get.to(()=> const HomeWorkScreen());

    }
    break;
      default:
        {
          Get.to(()=> const ChooseStateScreen());

          break;
        }
    }

  }
  androidNotificationChannel() => const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title

    importance: Importance.max,
  );
}
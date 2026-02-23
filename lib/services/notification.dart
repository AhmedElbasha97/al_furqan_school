import 'package:al_furqan_school/views/loggedUser/Messages/messageScreen/MessagesScreen.dart';
import 'package:al_furqan_school/views/loggedUser/homework/homeWork.dart';
import 'package:al_furqan_school/views/loggedUser/quetion_bank/questionBank.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();

    // طلب الإذن
    final settings =
    await FirebaseMessaging.instance.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    // لو التطبيق اتفتح من إشعار وهو مقفول
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _handleMessage(initialMessage);
    }

    // لو اتفتح من الخلفية
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _handleMessage(message);
    });

    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  Future<void> registerNotificationListeners() async {
    // Android channel
    const AndroidNotificationChannel channel =
    AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Initialization settings
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings =
    InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // IMPORTANT (v16+)
    await flutterLocalNotificationsPlugin.initialize(

      onDidReceiveNotificationResponse:
          (NotificationResponse response) async {
        await notificationSelectingAction();
      }, settings: initSettings,
    );

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _handleMessage(message);

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;

      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              priority: Priority.high,
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    final type = message.data["page"];
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    prefs.setString("route", type ?? "");
  }

  static Future<void> notificationSelectingAction() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String? screenType = prefs.getString("route");

    if (screenType == null) return;

    switch (screenType.trim()) {
      case "teacher_msg":
        Get.to(() => const MessagesScreenTeacher());
        break;

      case "parent_msg":
        Get.to(() => const MessagesScreen(), arguments: [0]);
        break;

      case "student_msg":
        Get.to(() => const MessagesScreen(), arguments: [1]);
        break;

      case "student_homework":
        Get.to(() => const HomeWorkScreen());
        break;

      case "student_quest":
      case "parent_quest":
        Get.to(() => const QuestionBankScreen());
        break;

      case "student_report":
        Get.to(() => const HomeWorkScreen());
        break;

      default:
        Get.to(() => const ChooseStateScreen());
    }
  }
}
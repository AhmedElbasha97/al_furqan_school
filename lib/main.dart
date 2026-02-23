import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/services/notification.dart';
import 'package:al_furqan_school/views/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'I10n/AppLanguage.dart';
import 'I10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var type = message.data["page"];
  prefs.setString("route", type);

}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging.instance.requestPermission();
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  }

  // FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(appLanguage: appLanguage));

}
class MyApp extends StatefulWidget {
  final AppLanguage? appLanguage;
   const MyApp({Key? key, this.appLanguage}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var type = message.data["page"];
      prefs.setString("route", type);
    });
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
        statusBarColor: mainColor, // اللون اللي تحبه
        statusBarIconBrightness: Brightness.light, // أيقونات status bar
        systemNavigationBarColor: mainColor, // اللون اللي تحبه للشريط السفلي
        systemNavigationBarIconBrightness: Brightness.light, // أيقونات الشريط السفلي
      ),
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var type = message.data["page"];
      prefs.setString("route", type);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: mainColor, // اللون اللي تحبه
        statusBarIconBrightness: Brightness.light, // أيقونات status bar
        systemNavigationBarColor: mainColor, // اللون اللي تحبه للشريط السفلي
        systemNavigationBarIconBrightness: Brightness.light, // أيقونات الشريط السفلي
      ),
    );
    return ChangeNotifierProvider(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return GetMaterialApp(

              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: const [
                Locale("en", "US"),
                Locale("ar", ""),
              ],
              locale: model.appLocal,
              title: 'مدارس الريان',
              theme: ThemeData(
                scaffoldBackgroundColor: white,
                primaryColor: mainColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: mainColor,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: mainColor,
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: mainColor,
                  selectedItemColor: mainColor,
                  unselectedItemColor: Colors.grey,
                ),
                textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'DroidKufi',
                ),
              ),
              home: const SplashScreen(),
            );
          },
        ));
  }
}

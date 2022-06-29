import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_icon_badge/flutter_app_icon_badge.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'I10n/AppLanguage.dart';
import 'I10n/app_localizations.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(appLanguage: appLanguage));
}
Future<void>backGroundHandler(message)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var counter = prefs.getInt("route");
  if(prefs.containsKey("counter")){
    prefs.setInt("counter", counter!+1);
  }else{
    prefs.setInt("counter", 1);
  }

  FlutterAppIconBadge.updateBadge(counter??1);
  prefs.setString("route", "${message.data["type"]}");
}
class MyApp extends StatefulWidget {
  final AppLanguage? appLanguage;
   const MyApp({Key? key, this.appLanguage}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

      DeviceOrientation.portraitDown,
    ]);
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

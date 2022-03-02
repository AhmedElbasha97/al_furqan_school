import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/splashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import 'I10n/AppLanguage.dart';
import 'I10n/app_localizations.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatelessWidget {
  final AppLanguage? appLanguage;
   const MyApp({Key? key, this.appLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
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

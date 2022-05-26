// ignore_for_file: file_names
import 'dart:io';
import 'package:al_furqan_school/models/new/social_link.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/albums/AlbumsScreen.dart';
import 'package:al_furqan_school/views/appData/newsScreen/NewsScreen.dart';
import 'package:al_furqan_school/views/appData/about/aboutApp.dart';
import 'package:al_furqan_school/views/appData/contact_us/contact_us_screen.dart';
import 'package:al_furqan_school/views/appData/privacypolicy/privacyPolicyScreen.dart';
import 'package:al_furqan_school/views/appData/supject/subjectsScreen.dart';
import 'package:al_furqan_school/views/auth/login/login.dart';
import 'package:al_furqan_school/views/myAccount.dart';
import 'package:al_furqan_school/views/myAccountTeacher.dart';
import 'package:al_furqan_school/views/myAccoutParent.dart';
import 'package:al_furqan_school/views/other/joinRequest/joinRequest.dart';
import 'package:al_furqan_school/views/splashScreen.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/startScreens/choose_state_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late bool userLogged =false;
  bool isLoading=true;
  late bool isStudent;
  late bool isTeacher;
  late SocialLinkModel socials =SocialLinkModel();

  @override
  void initState() {
    super.initState();
    checkData();
    getData();
  }

  checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLogged = prefs.getString("id") == null ? false : true;
    isStudent = prefs.getString("type") == "STUDENT" ? true : false;
    isTeacher = prefs.getString("type") == "TEACHER" ? true : false;

    setState(() {});
  }
getData() async {
  socials= await AppInfoService().gatSocialLink();
  isLoading = false;
  setState(() {});
}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mainColor,
      child: ListView(
        children: [
          Container(
            color: white,
              child: Image.asset("assets/images/logo 2020 new.png",
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.4,)),
          const SizedBox(height: 10),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('homePage')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.home,color: white,),
            onTap: () {
              Get.to(()=>const ChooseStateScreen());
            },
          ),
           Divider(
            color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('joinRequest')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.person_add_rounded,color: white,),
            onTap: () {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const JoinRequest(),
              ));
            },
          ),
           Divider(
            color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          userLogged
              ? ListTile(
                  title: Text(
                    "${AppLocalizations.of(context)!.translate('myAccount')}",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  leading:  Icon(Icons.person,color: white,),
                  onTap: () {
                    popPage(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => isStudent
                          ? const MyAccount()
                          : isTeacher
                              ? const MyAccountTeacher()
                              : const MyAccountParent(),
                    ));
                  },
                )
              : ListTile(
                  title: Text(
                    "${AppLocalizations.of(context)!.translate('login')}",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  leading:  Icon(Icons.login,color: white,),
                  onTap: () {
                    popPage(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                  },
                ),
           Divider(
            color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),

          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('complains')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.photo,color: white,),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ContactUsScreen(),
              ));
            },
          ),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('PhotosAlbum')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.photo,color: white,),
            onTap: () async {
           Get.to(()=>const AlbumsScreen(),arguments: [true]);
            },
          ),

           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('videosAlbum')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.video_library,color: white,),
            onTap: () async {
              Get.to(()=>const AlbumsScreen(),arguments: [false]);
            },
          ),
           Divider(
            color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('books')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.auto_stories,color: white,),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SubjectsScreen(),
              ));
            },
          ),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('newNews')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.public,color: white,),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewsScreen(),
              ));
            },
          ),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
              title: Text(
                "${AppLocalizations.of(context)!.translate('aboutTheApp')}",
                style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              leading:  Icon(Icons.description,color: white,),
              onTap: () {
                popPage(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutAppScreen(),
                ));
              }),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
              title: Text(
                "${AppLocalizations.of(context)!.translate('privacyPolicy')}",
                style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              leading:  Icon(Icons.description,color: white,),
              onTap: () {
                popPage(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ));
              }),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          isLoading? Container():ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('share')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.share,color: white,),
            onTap: () {

    Share.share(Platform.isAndroid
    ? socials.androidLink!
        : socials.iosLink!,);



            },
          ),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              "مكان مدرسه الفرقان",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.location_on_outlined,color: white,),
            onTap: () async {
              await MapLauncher.showMarker(
                mapType: Platform.isAndroid
                    ?MapType.google:MapType.apple,
                coords: Coords(25.31689362643027, 51.463605881113786),
                title: "مكان مدرسه الفرقان",
                description: "مكان مدرسه الفرقان",
              );
            },
          ),
           Divider(
             color: white,
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),

          userLogged
              ? ListTile(
                  title: Text(
                    "${AppLocalizations.of(context)!.translate('signOut')}",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  leading:  Icon(Icons.exit_to_app,color: white,),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    popPage(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ));
                  },
                )
              : Container(),
          const SizedBox(height: 15,),
          isLoading? Container():Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
              InkWell(
                 onTap: () => launchURL(socials.facebook??"","فيس بوك",context),
                child: Image.asset(
                  "assets/images/facebook.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL(socials.instagram??"","انستجرام",context),
                child: Image.asset(
                  "assets/images/instagram.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL(socials.twitter??"","تويتر",context),
                child: Image.asset(
                  "assets/images/twitter.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL("https://wa.me/${socials.whatsapp??""}","واتس اب",context),
                child: Image.asset(
                  "assets/images/whatsapp.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL(socials.snapchat??"","سناب شات",context),
                child: Image.asset(
                  "assets/images/snapchat.png",
                  scale: 1.5,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
            ],
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${AppLocalizations.of(context)!.translate('policy1')}",
              style:  TextStyle(fontSize: 15,color: white,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("${AppLocalizations.of(context)!.translate('policy2')}",
                    style:  TextStyle(fontSize: 16,color: white,)),
                InkWell(
                  onTap: () => launchURL("https://syncqatar.com","",context),
                  child:  Text(
                    "سينك",
                    style: TextStyle(
                        color: teal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/albums/AlbumsScreen.dart';
import 'package:al_furqan_school/views/appData/NewsScreen.dart';
import 'package:al_furqan_school/views/appData/aboutApp.dart';
import 'package:al_furqan_school/views/appData/contact_us_screen.dart';
import 'package:al_furqan_school/views/appData/privacyPolicyScreen.dart';
import 'package:al_furqan_school/views/appData/subjectsScreen.dart';
import 'package:al_furqan_school/views/auth/login.dart';
import 'package:al_furqan_school/views/myAccount.dart';
import 'package:al_furqan_school/views/myAccountTeacher.dart';
import 'package:al_furqan_school/views/myAccoutParent.dart';
import 'package:al_furqan_school/views/other/joinRequest.dart';
import 'package:al_furqan_school/views/splashScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late bool userLogged;
  late bool isStudent;
  late bool isTeacher;

  @override
  void initState() {
    super.initState();
    checkData();
  }

  checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLogged = prefs.getString("id") == null ? false : true;
    isStudent = prefs.getString("type") == "STUDENT" ? true : false;
    isTeacher = prefs.getString("type") == "TEACHER" ? true : false;
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

              child: Image.asset("assets/images/logo1.png")),
          const SizedBox(height: 10),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('homePage')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.home,color: white,),
            onTap: () {
              popPage(context);
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
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AlbumsScreen(),
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
              "${AppLocalizations.of(context)!.translate('videosAlbum')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.video_library,color: white,),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AlbumsScreen(
                  isImg: false,
                ),
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
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.translate('share')}",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading:  Icon(Icons.share,color: white,),
            onTap: () {
              String link =
                  "https://play.google.com/store/apps/details?id=com.syncQatar.rayanSchool";
              if (Platform.isIOS) {
                link =
                    "https://apps.apple.com/us/app/%D9%85%D8%AF%D8%B1%D8%B3%D8%A9-%D8%A7%D9%84%D8%B1%D9%8A%D8%A7%D9%86/id1563613632";
              }


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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
              InkWell(
                // onTap: () => launchURL("$facebookUrl"),
                child: Image.asset(
                  "assets/images/facebook.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("$instagramUrl"),
                child: Image.asset(
                  "assets/images/instagram.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("$twitterUrl"),
                child: Image.asset(
                  "assets/images/twitter.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("https://wa.me/$whatsappUrl"),
                child: Image.asset(
                  "assets/images/whatsapp.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("$youtubeUrl"),
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
                  onTap: () => launchURL("https://syncqatar.com"),
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

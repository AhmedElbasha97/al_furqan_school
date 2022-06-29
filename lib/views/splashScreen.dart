// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loggedUser/Messages/messageScreen/MessagesScreen.dart';
import 'loggedUser/homework/homeWork.dart';
import 'loggedUser/quetion_bank/questionBank.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    goToHome();
  }

  goToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    FirebaseMessaging.onMessageOpenedApp.listen((message) {

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
  );
    Future.delayed(
        const Duration(seconds: 3),
        () =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ChooseStateScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo 2020 new.png",
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width*0.8,),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            color: mainColor,
            backgroundColor: white,
          ),
        ],
      )),
    );
  }
}

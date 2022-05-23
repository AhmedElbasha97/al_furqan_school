// ignore: file_names


import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sendMassageStudent/sendMessageStudent.dart';
import 'package:al_furqan_school/views/parents/attendance/AttendanceScreen.dart';
import 'package:al_furqan_school/views/parents/report/ReportsScreen.dart';
import 'package:al_furqan_school/views/parents/studentlist/students_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../globals/commonStyles.dart';
import 'loggedUser/Messages/messageScreen/MessagesScreen.dart';
import 'loggedUser/Messages/sentMessage/sentMessageScreen.dart';

class MyAccountParent extends StatelessWidget {
  const MyAccountParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:AssetImage("assets/images/imageplaceholder-image.jpg") ,
                        ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("اسم ولى الامر",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: mainColor
                        ),
                        ),
                        const Text("الطالب المختار:اسم الطالب",style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey
                        ),
                        ),
                        InkWell(
                          onTap: (){
                            pushPage(
                                context,
                                const StudentListScreen());
                          },
                          child: Row(
                            children: [
                               Text("قأمة الطلاب المسجلين",style: TextStyle(

                                fontSize: 10,
                                color: teal
                              ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: teal,size: 15,)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: mainColor,),
              ListTile(
                onTap: () {
                  pushPage(context, const ReportScreen());
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('reports')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.book,color: mainColor),
              ),
               Divider(color: mainColor,),
              ListTile(
                  onTap: () {
                    pushPage(context, const AttendanceScreen());
                  },
                  title: Text(
                    AppLocalizations.of(context)!.translate('attendance')!,style: TextStyle(color: mainColor),
                  ),
                  trailing:  Icon(Icons.person,color: mainColor)),
               Divider(
                 color: mainColor,
               ),
              ListTile(
                onTap: () {
                  Get.to(()=> const SentMessagesScreen(),arguments: [0]);
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('sentMessages')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.message,color: mainColor,),
              ),
               Divider(
                color: mainColor,
              ),
              ListTile(
                onTap: () {
                  Get.to(()=> const MessagesScreen(),arguments: [0]);
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('messages')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.message,color: mainColor,),
              ),
               Divider(color: mainColor,),
              ListTile(
                onTap: () {
                  Get.to(()=> const SendMessageStudentScreen(),arguments: [0]);
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('sendMessage')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.message_rounded,color: mainColor,),
              ),
            ])));
  }
}

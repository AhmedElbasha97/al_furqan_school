// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:al_furqan_school/views/teacher/messages/sentMessageTeacher/sendMessageTeacher.dart';
import 'package:al_furqan_school/views/teacher/questionBank/questionBank.dart';
import 'package:al_furqan_school/views/teacher/reportScreen/reportsScreen.dart';
import 'package:al_furqan_school/views/teacher/schedules/scheduleScreen.dart';
import 'package:al_furqan_school/views/teacher/send_report/sendReport.dart';
import 'package:flutter/material.dart';

import '../globals/commonStyles.dart';


class MyAccountTeacher extends StatefulWidget {
  const MyAccountTeacher({Key? key}) : super(key: key);

  @override
  State<MyAccountTeacher> createState() => _MyAccountTeacherState();
}

class _MyAccountTeacherState extends State<MyAccountTeacher> {
  bool isOffline = false;

  @override
  void initState()  {
    super.initState();
    GetData();
  }
  GetData() async {
    isOffline = !await connectivityChecker();
    setState(() {  });
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){

    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
    setState(() {  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar:isOffline?OfflineWidget(refreshedFunc: (){refreshFunction();},):const SizedBox(height: 0,width: 0,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                pushPage(context, const ReportScreen());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('reports')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.book,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                pushPage(context, const SendReport());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('sendReport')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.message,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
                onTap: () {
                  pushPage(context, const TeacherSchedule());
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('schedule')!,
                  style: TextStyle(color: mainColor),

                ),
                trailing:  Icon(Icons.timer,color: mainColor)),
            Divider(color: mainColor),
            ListTile(
              onTap: () {
                pushPage(context, const SendMessageStudentScreen());
              },
              title: Text(
               "ارسال رسالة",
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.message,color: mainColor),
            ),
            Divider(color: mainColor),
            ListTile(
              onTap: () {
                pushPage(context, const MessagesScreenTeacher());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('sentMessages')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.message,color: mainColor),
            ),
             Divider(color: mainColor),
            ListTile(
              onTap: () {
                pushPage(context, const SendReport());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('homeWorks')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.message,color: mainColor),
            ),
             Divider(color: mainColor),
            ListTile(
              onTap: () {
                pushPage(context, const QuestionBankScreen());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('questionsBank')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.help,color: mainColor),
            ),
          ],
        ),
      ),
    );
  }
}

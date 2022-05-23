// ignore_for_file: file_names

import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/MessagesScreen.dart';
import 'package:al_furqan_school/views/teacher/messages/sentMessageTeacher/sendMessageTeacher.dart';
import 'package:al_furqan_school/views/teacher/questionBank/questionBank.dart';
import 'package:al_furqan_school/views/teacher/reportScreen/reportsScreen.dart';
import 'package:al_furqan_school/views/teacher/schedules/scheduleScreen.dart';
import 'package:al_furqan_school/views/teacher/send_report/sendReport.dart';
import 'package:flutter/material.dart';

import '../globals/commonStyles.dart';


class MyAccountTeacher extends StatelessWidget {
  const MyAccountTeacher({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
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
                pushPage(context, const MessagesScreen());
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

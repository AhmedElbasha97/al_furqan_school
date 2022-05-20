// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/Student/askedQuestion/AskedQuestion.dart';
import 'package:al_furqan_school/views/Student/books/bookScreen.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/messageScreen/MessagesScreen.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sendMassageStudent/sendMessageStudent.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sentMessage/sentMessageScreen.dart';
import 'package:al_furqan_school/views/loggedUser/homework/homeWork.dart';
import 'package:al_furqan_school/views/loggedUser/importantfiles/importantFilesScreen.dart';
import 'package:al_furqan_school/views/loggedUser/quetion_bank/questionBank.dart';
import 'package:get/get.dart';

import '../globals/commonStyles.dart';
import 'loggedUser/filescreen/fileScreen.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);


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
                pushPage(context, const HomeWorkScreen());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('homeWorks')!,
                style: TextStyle(color: mainColor),
              ),
              trailing:  Icon(Icons.book,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
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
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                pushPage(context, const FilesScreen());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('files')!,
                style: TextStyle(color: mainColor),
              ),
              trailing:  Icon(Icons.file_present,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                pushPage(context, const FilesImportantScreen());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('impProg')!,
                style: TextStyle(color: mainColor),
              ),
              trailing:  Icon(Icons.file_present,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                Get.to(()=> const SendMessageStudentScreen(),arguments: [1]);
              },
              title: Text(
                AppLocalizations.of(context)!.translate('sendMessage')!,
                style: TextStyle(color: mainColor),
              ),
              trailing:  Icon(Icons.message_rounded,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {},
              title: Text(
                AppLocalizations.of(context)!.translate('results')!,
                style: TextStyle(color: mainColor),
              ),
              trailing:  Icon(Icons.check_box,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                pushPage(context, const AskedQuestions());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('questionsStudent')!,
                style: TextStyle(color: mainColor),
              ),
              trailing:  Icon(Icons.help_center,color: mainColor),
            ),
             Divider(
                color: mainColor
            ),
            ListTile(
              onTap: () {
                pushPage(context, const BooksScreen());
              },
              title: Text(
                AppLocalizations.of(context)!.translate('booksnref')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.book,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                Get.to(()=> const MessagesScreen(),arguments: [1]);
              },
              title: Text(
                AppLocalizations.of(context)!.translate('messages')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.message,color: mainColor),
            ),
             Divider(
                 color: mainColor
             ),
            ListTile(
              onTap: () {
                Get.to(()=> const SentMessagesScreen(),arguments: [1]);
              },
              title: Text(
                AppLocalizations.of(context)!.translate('sentMessages')!,
                style: TextStyle(color: mainColor),

              ),
              trailing:  Icon(Icons.message,color: mainColor),
            ),
             Divider(color: mainColor),
            ListTile(
                onTap: () {},
                title: Text(
                  AppLocalizations.of(context)!.translate('schedule')!,
                  style: TextStyle(color: mainColor),

                ),
                trailing:  Icon(Icons.timer,color: mainColor)),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

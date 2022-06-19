// ignore_for_file: file_names

import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals/commonStyles.dart';
import 'Student/schadules/schadules_screen.dart';
import 'loggedUser/filescreen/fileScreen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
      bottomNavigationBar:isOffline?OfflineWidget(refreshedFunc: (){refreshFunction();},):const SizedBox(width: 0,height: 0,),
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
              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? id = prefs.getString("id");
                if ( await launchUrl(Uri.parse("https://alforqanschools.sch.qa/site/reportyear.php?studentid=$id"),mode: LaunchMode.externalApplication)) {

                showTheDialog(context, "حدث خطأ الان", "لا يمكن الآن الذهاب الى هذه الصفحه الان");
                throw 'Could not launch ${"https://alforqanschools.sch.qa/site/reportyear.php?studentid=$id"}';

                }
              },
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
                onTap: () {
                  Get.to(()=> const SchedulesScreen());
                },
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

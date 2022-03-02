// ignore: file_names


import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sendMessageStudent.dart';
import 'package:al_furqan_school/views/parents/AttendanceScreen.dart';
import 'package:al_furqan_school/views/parents/ReportsScreen.dart';
import 'package:flutter/material.dart';
import '../globals/commonStyles.dart';
import 'loggedUser/Messages/MessagesScreen.dart';
import 'loggedUser/Messages/sentMessageScreen.dart';

class MyAccountParent extends StatefulWidget {
  const MyAccountParent({Key? key}) : super(key: key);

  @override
  _MyAccountParentState createState() => _MyAccountParentState();
}

class _MyAccountParentState extends State<MyAccountParent> {
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
              ListTile(
                onTap: () {
                  pushPage(context, const ReportScreen());
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('reports')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.book,color: mainColor),
              ),
              const Divider(),
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
                  pushPage(
                      context,
                      const SentMessagesScreen(
                        type: 2,
                      ));
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
                  pushPage(
                      context,
                      const MessagesScreen(
                        type: 2,
                      ));
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('messages')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.message,color: mainColor,),
              ),
               Divider(color: mainColor,),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      const SendMessageStudentScreen(
                        type: 2,
                      ));
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('sendMessage')!,style: TextStyle(color: mainColor),
                ),
                trailing:  Icon(Icons.message_rounded,color: mainColor,),
              ),
            ])));
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teacher/sentMessages.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:al_furqan_school/views/teacher/messages/messageDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool isLoading = true;
  List<SentMessagesTeacher> messages = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    messages = await TeacherService().getSentMessages(
      id: id,
    );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      pushPage(
                          context,
                          MessageDetailsScreen(
                            id: "${messages[index].msgId}",
                          ));
                    },
                    title: Text("${messages[index].title}"),
                    trailing: Text("${messages[index].date}"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
    );
  }
}

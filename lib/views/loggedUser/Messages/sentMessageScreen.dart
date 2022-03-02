// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/MessageSentStudent.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sentMessageDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentMessagesScreen extends StatefulWidget {
  final int type;
  const SentMessagesScreen({Key? key, this.type = 1}) : super(key: key);
  @override
  _SentMessagesScreenState createState() => _SentMessagesScreenState();
}

class _SentMessagesScreenState extends State<SentMessagesScreen> {
  bool isLoading = true;
  List<MessageSentStudent> messages = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    messages = widget.type != 1
        ? await ParentService().getSentMessages(
            id: id,
          )
        : await MessagesService().getSentMessages(
            id: id,
          );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
      body: isLoading
          ?  Center(
              child: CircularProgressIndicator(
                color: mainColor,
                backgroundColor: white,
              ),
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
                          SentMessageDetails(
                            type: widget.type,
                            id: messages[index].msgId,
                          ));
                    },
                    title: Text("${messages[index].title}"),
                    trailing: Text("${messages[index].date}",style: TextStyle(color: mainColor),),
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

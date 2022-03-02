// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:al_furqan_school/models/messageDetails.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsScreen extends StatefulWidget {
  final String? id;
  final int type;
  const MessageDetailsScreen({Key? key, this.id = "", this.type = 1}) : super(key: key);
  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  bool isLoading = true;
  List<MessageDetails> msg = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    msg = widget.type != 1
        ? await ParentService().getMessageDetails(id: id, msgId: widget.id)
        : await MessagesService().getMessageDetails(id: id, msgId: widget.id);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: mainColor,
                backgroundColor: white,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: msg.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${msg[index].title}"),
                      Text("${msg[index].date}"),
                      Text(msg[index].from ?? ""),
                      Html(data: "${msg[index].text}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

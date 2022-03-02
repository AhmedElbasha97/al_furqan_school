// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/models/teacher/messagedetails.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsScreen extends StatefulWidget {
  final String id;
  const MessageDetailsScreen({Key? key, this.id = ""}) : super(key: key);
  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  bool isLoading = true;
  List<MessageDetailsTeacherModel> msg = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    msg =
        await TeacherService().getsentMessageDetails(id: id, msgId: widget.id);
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
                      Text(msg[index].to ?? ""),
                      Html(data: "${msg[index].text}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

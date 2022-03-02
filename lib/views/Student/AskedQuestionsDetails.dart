// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/models/Student/AskedQuestionDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskedQuestionsDetailsScreen extends StatefulWidget {
  final String? id;
  const AskedQuestionsDetailsScreen({Key? key, this.id}) : super(key: key);
  @override
  _AskedQuestionsDetailsScreenState createState() =>
      _AskedQuestionsDetailsScreenState();
}

class _AskedQuestionsDetailsScreenState
    extends State<AskedQuestionsDetailsScreen> {
  bool isLoading = true;
  List<AskedQuestionDetails> details = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    details = await LoggedUser()
        .getAskedQuestionsDetails(id: id, qid: widget.id ?? "");
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
          : ListView.builder(
              itemCount: details.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${details[index].title}"),
                      Text("${details[index].date}"),
                      Text("${details[index].from}"),
                      Html(data: "${details[index].text}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/Student/AskedQuestion.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/views/Student/AskedQuestionsDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskedQuestions extends StatefulWidget {
  const AskedQuestions({Key? key}) : super(key: key);

  @override
  _AskedQuestionsState createState() => _AskedQuestionsState();
}

class _AskedQuestionsState extends State<AskedQuestions> {
  bool isLoading = true;
  List<AskedQuestion> question = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    question = await LoggedUser().getAskedQuestions(id: id);
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
              itemCount: question.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () async {
                      pushPage(
                          context,
                          AskedQuestionsDetailsScreen(
                              id: question[index].msgId));
                    },
                    title: Text("${question[index].title}"),
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

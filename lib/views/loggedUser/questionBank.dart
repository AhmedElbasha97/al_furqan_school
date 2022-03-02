// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/models/question.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/views/loggedUser/questionsDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({Key? key}) : super(key: key);

  @override
  _QuestionBankScreenState createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  bool isLoading = true;
  List<Question> questions = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    questions = await LoggedUser().getQuestions(id: id);
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
          ? Center(
              child: CircularProgressIndicator(color: mainColor,
                backgroundColor: white,),
            )
          : ListView.builder(
       itemCount: questions.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      pushPage(
                          context,
                          QuestionDetailsScreen(
                            id: questions[index].id??"",
                          ));
                    },
                    child: HomeWorkCard(
                      title: "${questions[index].title}",
                      date: "${questions[index].date}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

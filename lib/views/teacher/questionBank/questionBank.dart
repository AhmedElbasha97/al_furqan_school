// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/questionBank/controller/question_bank_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:get/get.dart';


class QuestionBankScreen extends StatelessWidget {
  const QuestionBankScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: QuestionBankController(context),
      builder: (QuestionBankController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: mainColor),
          backgroundColor: Colors.white,
        ),
        body:controller.isLoading
            ? const Loader()
            :controller.questions.isEmpty?
        RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_question_bank.png"),
                    Text("ليس متوفر الان أسأله الان في بنك الاسألة",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
                  ],
                ),
              ),
            )): RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
              child: ListView.builder(
                  itemCount: controller.questions.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: HomeWorkCard(
                          title: "${controller.questions[index].title}",
                          date: "${controller.questions[index].date}",
                        ),
                      ),
                    );
                  },
                ),
            ),
      ),
    );
  }
}

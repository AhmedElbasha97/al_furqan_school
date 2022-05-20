// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/quetion_bank/controller/question_bank_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/views/loggedUser/questionDetails/questionsDetails.dart';
import 'package:get/get.dart';
class QuestionBankScreen extends StatelessWidget {
  const QuestionBankScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:  QuestionBankController(context),
        builder: (QuestionBankController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ? const Loader()
            : controller.hasNoData?
        RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/no_question_bank.png"),
                      Text("ليس متوفر الان أسأله الان في بنك الاسألة",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            )):RefreshIndicator(
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
                        onTap: () {
                      Get.to(()=>const QuestionDetailsScreen(),arguments: [controller.questions[index].id],);},
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

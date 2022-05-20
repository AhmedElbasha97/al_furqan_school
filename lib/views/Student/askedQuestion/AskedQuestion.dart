// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/Student/askedQuestion/controller/asked_question_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/views/Student/askedquestiondetails/AskedQuestionsDetails.dart';
import 'package:get/get.dart';

class AskedQuestions extends StatelessWidget {
  const AskedQuestions({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  AskedQuestionController(context),
      builder: (AskedQuestionController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body:  controller.isLoading
            ?  const Loader()
            :  controller.hasNoData?
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
                      Text("ليس هناك اى اسأل تم الاستفسار عنها",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            )):    RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
              child: ListView.separated(
                  itemCount:  controller.question.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          Get.to(()=>const AskedQuestionsDetailsScreen(),arguments: [controller.question[index].msgId]);
                        },
                        title: Text("${ controller.question[index].title}"),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
            ),
      ),
    );
  }
}

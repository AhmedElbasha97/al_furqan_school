// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/Student/askedquestiondetails/controller/asked_question_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class AskedQuestionsDetailsScreen extends StatelessWidget {

  const AskedQuestionsDetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  AskedQuestionDetailsController(context),
      builder: (AskedQuestionDetailsController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ?  Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                  backgroundColor: white,
                ),
              )
            : ListView.builder(
                itemCount: controller.details.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.details[index].title}"),
                        Text("${controller.details[index].date}"),
                        Text("${controller.details[index].from}"),
                       controller.hasNoData?Container() :Html(data: "${controller.details[index].text}"),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

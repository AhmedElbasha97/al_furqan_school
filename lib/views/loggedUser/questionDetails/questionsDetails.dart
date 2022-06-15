// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/questionDetails/controller/question_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:get/get.dart';


class QuestionDetailsScreen extends StatelessWidget {

  const QuestionDetailsScreen({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return GetBuilder(
      init:  QuestionDetailsController(context),
      builder: (QuestionDetailsController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ?  const Loader()
            : ListView.builder(
                itemCount: controller.questions.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.questions[index].title}",
                          style: TextStyle(color: mainColor),
                        ),
                        Text("${controller.questions[index].date}"),
                       controller.hasFileData(index)? Html(data: "${controller.questions[index].fileDet}"):Container(),

                            controller.hasFileLink(index)? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)!
                                      .translate('download')??"",
                                  onClick: () async {
                                    controller.launchURL(context, index);
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

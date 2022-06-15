// ignore_for_file: file_names

import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/homeworkdetails/controller/home_work_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:get/get.dart';
import '../../../globals/commonStyles.dart';

class HomeWorkDetailsScreen extends StatelessWidget {
  const HomeWorkDetailsScreen({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeWorkDetailsController(context),
      builder: (HomeWorkDetailsController controller) =>Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ? const Loader()
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount:  controller.homework.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${ controller.homework[index].title}"),
                        Text("${ controller.homework[index].date}"),
                        Text( controller.homework[index].teacherName ?? ""),
                        controller.hasNoData?  Container():Html(data: "${ controller.homework[index].homeworkDet}"),
                        controller.homework[index].homeworkFile != null
                            ? Padding(
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

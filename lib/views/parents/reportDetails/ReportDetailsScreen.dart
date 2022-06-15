// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/parents/reportDetails/controller/report_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ReportsDetailScreen extends StatelessWidget {

  const ReportsDetailScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  ReportDetailedController(context),
      builder: (ReportDetailedController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ? const Loader()
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount:  controller.reports.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${ controller.reports[index].student}"),
                        Text("${ controller.reports[index].date}"),
                        Text( controller.reports[index].teacher ?? ""),
                        controller.hasNoData?Container():Html(data: "${ controller.reports[index].text}"),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

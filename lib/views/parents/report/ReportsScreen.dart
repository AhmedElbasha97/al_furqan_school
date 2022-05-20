// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/parents/report/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/views/parents/reportDetails/ReportDetailsScreen.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:  ReportController(context),
        builder: (ReportController controller) =>
        Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ?  const Loader()
            :controller.hasNoData?
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
                      Image.asset("assets/images/no_reports.png"),
                      Text("ليس هناك تقرير متوفره الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            )):  RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
              child: ListView.separated(
                  itemCount: controller.reports.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Get.to(()=> const ReportsDetailScreen(),arguments: [controller.reports[index].reportId]);
                        },
                        title: Text("${controller.reports[index].teacher}"),
                        trailing: Text("${controller.reports[index].date}",style: TextStyle(color: mainColor),),
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

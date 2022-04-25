// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/homeworkdetails/controller/home_work_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/models/homeWorkDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWorkDetailsScreen extends StatefulWidget {

  const HomeWorkDetailsScreen({Key? key,}) : super(key: key);
  @override
  _HomeWorkDetailsScreenState createState() => _HomeWorkDetailsScreenState();
}

class _HomeWorkDetailsScreenState extends State<HomeWorkDetailsScreen> {




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  HomeWorkDetailsController(),
      builder: (HomeWorkDetailsController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ? const Loader()
            : controller.hasNoData?RefreshIndicator(
          onRefresh:()async{ controller.getData();},
              child: SingleChildScrollView(
                child: Container(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Component 1 – 1@3x.png"),
                  Text("ليس متوفر بيانات لهذا الواجب المنزلي",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
                ],
          ),
        ),
              ),
            ):
        RefreshIndicator(
          onRefresh: () async {controller.getData();},
          child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.homework.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${controller.homework[index].title}", style: TextStyle(color: mainColor),
                          ),
                          Text("${controller.homework[index].date}",),
                          Text("${controller.homework[index].teacherName ?? ""}"),
                          Html(data: "${controller.homework[index].homeworkDet}"),
                          controller.homework[index].homeworkFile != null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AppBtn(
                                    label: "تحميل",

                                    onClick: () async {
                                      if (await canLaunch(
                                          "${controller.homework[index].homeworkFile}")) {
                                        await launch(
                                            "${controller.homework[index].homeworkFile}");
                                      } else {
                                        throw 'Could not launch ${controller.homework[index].homeworkFile}';
                                      }
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
      ),
    );
  }
}

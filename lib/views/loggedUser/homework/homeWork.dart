// ignore_for_file: file_names


import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/homework/controller/home_work_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/models/homeWork.dart';
import 'package:al_furqan_school/views/loggedUser/homeworkdetails/HomeWorkDetailsScreen.dart';
import 'package:get/get.dart';

import '../../../globals/commonStyles.dart';

class HomeWorkScreen extends StatefulWidget {
  const HomeWorkScreen({Key? key}) : super(key: key);

  @override
  _HomeWorkScreenState createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  HomeWorkController(),
      builder: (HomeWorkController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ? const Loader()
            :
        controller.hasNoData?RefreshIndicator(
          onRefresh: () async {controller.getData();},
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Component 1 – 1@3x.png"),
                  Text("ليس لديك واجب الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
                ],
              ),
            ),
          ),
        ):RefreshIndicator(
          onRefresh: () async {controller.getData();},
          child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.homeworks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(const HomeWorkDetailsScreen(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(seconds: 1),
                            arguments: [controller.homeworks[index].id??""],
                            preventDuplicates: true);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HomeWorkCard(
                          title: controller.homeworks[index].title ?? "",
                          date: controller.homeworks[index].date ?? "",
                          teacherName: "${controller.homeworks[index].teacherName ?? ""}",
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

// ignore_for_file: file_names

import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/homework/controller/home_work_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/views/teacher/homeworkdetails/homeWorkDetail.dart';
import 'package:get/get.dart';
import '../../../globals/commonStyles.dart';

class HomeWorkScreen extends StatelessWidget {
  const HomeWorkScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeWorkController(context),
      builder: (HomeWorkController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ? const Loader()
            :  controller.hasNoData?RefreshIndicator(
          onRefresh: () async {controller.getData();},
          child: SingleChildScrollView(
            child: SizedBox(
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

                          arguments: [controller.homeworks[index].id??""],
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HomeWorkCard(
                          title: controller.homeworks[index].title ?? "",
                          date: controller.homeworks[index].date ?? "",
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

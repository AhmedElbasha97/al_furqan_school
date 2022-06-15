// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/schedules/controller/schedules_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherSchedule extends StatelessWidget {
  const TeacherSchedule({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SchedulesController(context),
      builder: (SchedulesController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ?const Loader()
            : controller.hasNoData?RefreshIndicator(
          onRefresh: () async {controller.getData();},
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_schadules.png"),
                  Text("ليس لديك أى مواضيع متاح للك الآن",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
                ],
              ),
            ),
          ),
        ):RefreshIndicator(
          onRefresh: () async {controller.getData();},
              child: ListView.separated(
                  itemCount: controller.schedule.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.schedule[index].day}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          controller.hasAnyScheduleThisDay(index)? Column(
                            children: [
                              Text("${controller.schedule[index].class1??""}"),
                              Text("${controller.schedule[index].class2??""}"),
                              Text("${controller.schedule[index].class3??""}"),
                              Text("${controller.schedule[index].class4??""}"),
                              Text("${controller.schedule[index].class5??""}"),
                              Text("${controller.schedule[index].class6??""}"),
                              Text("${controller.schedule[index].class7??""}"),
                              Text("${controller.schedule[index].class8??""}"),
                            ],
                          ):Text("ليس لديك أى مواضيع متاح للك اليوم",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                          ,

                        ],
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

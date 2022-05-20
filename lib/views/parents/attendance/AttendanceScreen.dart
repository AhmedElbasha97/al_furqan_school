// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/parents/attendance/controller/attandance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  AttendanceController(context),
      builder: (AttendanceController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ?  const Loader():controller.hasNoData?
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
                      Image.asset("assets/images/no_attendance.png"),
                      Text("ليس هناك جداول حضور متوفره الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            )):
        RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
              child: ListView.separated(
                  itemCount:  controller.attendance.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text("${ controller.attendance[index].status}"),
                        trailing: Text("${ controller.attendance[index].date}",style: TextStyle(color: mainColor),),
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

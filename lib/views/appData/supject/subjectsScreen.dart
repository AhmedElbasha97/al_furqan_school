// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/appData/subjectDetails/subject_details.dart';
import 'package:al_furqan_school/views/appData/supject/controller/supject_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:  SubjectController(context),
    builder: (SubjectController controller) =>    Scaffold(
          appBar: AppBar(
            iconTheme:  IconThemeData(color: white),
            backgroundColor: mainColor,
          ),
      bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),          body: controller.isLoading
              ?  const Loader()
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
                Image.asset("assets/images/no_books.png"),
                Text("ليس هناك مناهج متاحه الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                ],
                ),
                ),
                ),
                ):RefreshIndicator(
                onRefresh: () async {controller.getData();},
                child:ListView.separated(
                  itemCount: controller.subjects.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(()=>const SubjectDetailsScreen(),arguments: [controller.subjects[index].id,]);
                        },
                        child: ListTile(
                          title: Text("${controller.subjects[index].miName}"),
                          trailing:  Icon(Icons.arrow_forward_ios,color: mainColor,),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                )),
    ));
  }
}

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/parents/studentlist/controller/student_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../student_info_screen/student_info_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  StudentListController(context),
      builder: (StudentListController controller) => Scaffold(
        appBar: AppBar(
          title: const Text("الطلاب المسجلين"),
          centerTitle: true,
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
          bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ?  const Loader()
            :controller.studentList?.allStudents==null?
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
                      Image.asset("assets/images/no_student.png"),
                      Text("ليس هناك أى طلاب متوفرين الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            )):  RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
          child: ListView.builder(
            itemCount: controller.studentList?.allStudents!.length,

            itemBuilder:   (BuildContext context, int index) {
      return InkWell(
        onTap: (){
          Get.to(()=>const StudentInfoScreen(),arguments: [controller.studentList!.allStudents![index].id]);
        },
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: mainColor,
                  width: 2
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(controller.studentList!.allStudents![index].studentName??"",style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                       Text(controller.studentList!.allStudents![index].infoClass??"",style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),)
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                ],
              ),
            ),
        ),
      );


            } ,
          ),
        )
      ),
    );
  }
}

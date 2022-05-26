import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/parents/attendance/AttendanceScreen.dart';
import 'package:al_furqan_school/views/parents/report/ReportsScreen.dart';
import 'package:al_furqan_school/views/parents/student_info_screen/controller/student_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init:  StudentInfoController(context),
      builder: (StudentInfoController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
body: controller.isLoading?
const Loader()
    :SizedBox(
  width: Get.width,
  height: Get.height*0.7,
  child:   Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text("الأسم:",style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),

                   Expanded(

                    child: Text(
                      controller.student?.name??"",
                      softWrap: true,

                      overflow: TextOverflow.visible,
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),// new
                    ),
                  ),

                ],),

              ),

              Padding(

                padding: const EdgeInsets.all(8.0),

                child: Row(children: [

                  Text("الفصل:",style: TextStyle(

                    color: mainColor,

                    fontWeight: FontWeight.bold,

                    fontSize: 18,

                  ),),
                   Expanded(

                    child: Text(
                         controller.student?.class3??"",
                      softWrap: true,

                      overflow: TextOverflow.visible,
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),// new
                    ),
                  ),

                ],),

              ),

              Padding(

                padding: const EdgeInsets.all(8.0),

                child: Row(children: [

                  Text("الصف:",style: TextStyle(

                    color: mainColor,

                    fontWeight: FontWeight.bold,

                    fontSize: 18,

                  ),),

                   Expanded(

                    child: Text(
                      controller.student?.class2??"",
                      softWrap: true,

                      overflow: TextOverflow.visible,
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),// new
                    ),
                  ),

                ],),

              ),

              Padding(

                padding: const EdgeInsets.all(8.0),

                child: Row(children: [

                  Text("البريد الالكتروني:",style: TextStyle(

                    color: mainColor,

                    fontWeight: FontWeight.bold,

                    fontSize: 18,

                  ),),

                   Expanded(

                    child: Text(
                      controller.student?.email??"",
                      softWrap: true,

                      overflow: TextOverflow.visible,
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),// new
                    ),
                  ),

                ],),

              ),
            Padding(

              padding: const EdgeInsets.all(8.0),

              child: Row(children: [

                Text("المدرسة:",style: TextStyle(

                  color: mainColor,

                  fontWeight: FontWeight.bold,

                  fontSize: 18,

                ),),

                Expanded(

                  child: Text(
                    controller.student?.class1??"",
                    softWrap: true,

                    overflow: TextOverflow.visible,
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),// new
                  ),
                ),

              ],),

            ),
          ],

        ),
            ),

        Column(

              children: [

            InkWell(
              onTap: (){
                Get.to(()=>const ReportScreen(),arguments: [controller.student?.id??""]);
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

        Text("التقارير الخاصة بالطالب",style: TextStyle(

        color: mainColor,

        fontWeight: FontWeight.bold,

        fontSize: 18,

        ),),



        ],

        ),

        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)

        ],

        ),

        ),

        ),
            ),

                InkWell(
                  onTap: (){
                    Get.to(()=>const AttendanceScreen(),arguments: [controller.student?.id??""]);
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

        Text("الحضور والانصراف الخاص بالطالب",style: TextStyle(

        color: mainColor,

        fontWeight: FontWeight.bold,

        fontSize: 18,

        ),),



        ],

        ),

        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)

        ],

        ),

        ),

        ),
                ),

              ],

            )

      ],

  ),
),
      ),
    );
  }
}

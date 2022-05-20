import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/the%20_department/controller/the_department_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
class DepartmentDetailScreen extends StatelessWidget {
  const DepartmentDetailScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TheDepartmentController(context),
      builder: (TheDepartmentController controller) =>  Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading?const Loader():controller.hasNoData? SizedBox(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no-connection.png",height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width*0.4,),
              Text("ليس هناك معلومات متوفره عن هذا القسم الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30,),textAlign: TextAlign.center,)
            ],
          ),
        )
         :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(controller.department?.img??"",
              height: MediaQuery.of(context).size.height*0.23,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.6,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: mainColor,width: 2),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,//.horizontal
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  controller.department?.title??"",
                                  style: appText.copyWith(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),

                              ),
                            ),
                          ),
                          Html(data: controller.department?.brief),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/choose_department/controller/choose_department_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/the%20_department/the_department_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseDepartmentScreen extends StatelessWidget {
  const ChooseDepartmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
        init:  ChooseDepartmentController(context),
        builder: (ChooseDepartmentController controller) =>    Scaffold(
        appBar: AppBar(
        iconTheme:  IconThemeData(color: white),
    title: Text("المكاتب والأقسام",
      style: TextStyle(
          color: white, fontWeight: FontWeight.bold, fontSize: 14),),
    centerTitle: true,
    backgroundColor: mainColor,
    ),
    bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),        body: controller.isLoading
    ?const Loader():controller.hasNoData? SizedBox(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no-connection.png",height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width*0.4,),
              Text("ليس هناك اقسام او مكاتب متوفرة الأن",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30,),textAlign: TextAlign.center,)
            ],
          ),
        ):
        Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
            child:  Center(
              child: Image.asset("assets/images/logo 2020 new.png",
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.7,),
            ),
            ),
        Container(
          height:  MediaQuery.of(context).size.height*0.5,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(width: 3.0,color: mainColor),
            borderRadius: BorderRadius.circular(25),
            boxShadow:  [
              BoxShadow(
                color: white,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: ListView.builder(
              itemCount: controller.departmentData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Get.to(() =>const DepartmentDetailScreen(),
                      arguments: [controller.departmentData[index].id],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(width: 3.0,color: mainColor),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow:  [
                          BoxShadow(
                            color: white,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.departmentData[index].title!, style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.right,),
                            Icon(Icons.navigate_next_outlined,size: 40,color: mainColor,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },

            ),
          ),
        ),

          ],
        )));
  }
}

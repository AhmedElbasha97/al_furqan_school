// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/appData/pdfViewer/pdf_viewer.dart';
import 'package:al_furqan_school/views/appData/subjectDetails/controller/subject_details_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  SubjectDetailsController(context),
      builder: (SubjectDetailsController controller) =>    Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),        body: controller.isLoading
            ?const Loader()
            :controller.hasNoData?SizedBox(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no_books.png"),
              Text("ليس هناك اى معلومات متاحه الان عن هذا المنهج",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
            ],
          ),
        ): ListView.builder(
                itemCount: controller.details?.length,

                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration:const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width:1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${controller.details![index].title}", textAlign: TextAlign.center,),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width*0.6),
                              child: Text("${controller.details![index].brief}", textAlign: TextAlign.center),),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(()=>const PdfViewer(),arguments: [controller.details![index].file,controller.details![index].title]);
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.4,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                              ),
                              child:  Center(
                                child: Text("فتح الملف",style: TextStyle(color: white),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

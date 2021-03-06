// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/importantfiles/controller/important_files_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:get/get.dart';


class FilesImportantScreen extends StatelessWidget {
  const FilesImportantScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:  ImportantFilesController(context),
    builder: (ImportantFilesController controller) =>   Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
      bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),        body: controller.isLoading
            ? const Loader():
        controller.hasNoData?RefreshIndicator(
            onRefresh: () async {controller.getData();},
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_files.png"),
                    Text("ليس هناك ملفات متاحة للتحميل الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
                  ],
                ),
              ),
            )): RefreshIndicator(
          onRefresh: () async {controller.getData();},
              child: ListView.builder(
                  itemCount: controller.files.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          controller.launchURL(context, index);
                        },
                        child: HomeWorkCard(
                          title: "${controller.files[index].title}",
                          date: "${controller.files[index].desc}",
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

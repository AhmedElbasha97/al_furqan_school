// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/filescreen/controller/file_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/views/loggedUser/filesDetails/fileDetailsScreen.dart';
import 'package:get/get.dart';


class FilesScreen extends StatelessWidget {
  const FilesScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  FileScreenController(context),
      builder: (FileScreenController controller) =>  Scaffold(
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
    Image.asset("assets/images/no_files.png"),
    Text("ليس هناك ملفات متاحة للتحميل الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
    ],
    ),
    ),
    )):RefreshIndicator(
          onRefresh: () async {controller.getData();},
      child: ListView.builder(
                  itemCount: controller.files.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(()=>const FileDetailsScreen(),arguments: [ controller.files[index].id]);
                        },
                        child: HomeWorkCard(
                          title: "${controller.files[index].title}",
                          date: "${controller.files[index].date}",
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

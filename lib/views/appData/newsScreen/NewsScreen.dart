// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/appData/newsScreen/controller/news_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../newsDetails/NewsDetailsScreen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  NewsController(context),
      builder: (NewsController controller) =>  Scaffold(
          appBar: AppBar(
            iconTheme:  IconThemeData(color: white),
            backgroundColor: mainColor,
          ),
          body: controller.isLoading
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
    Image.asset("assets/images/Component 1 – 1@3x.png"),
    Text("ليس هناك اي اخبار الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
    ],
    ),
    ),
    )): RefreshIndicator(
            onRefresh: () async {controller.getData();},
      child: ListView.separated(
                    itemCount: controller.news.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(()=>  const NewsDetailsScreen(),
                            arguments: [controller.news[index].id]
                            );
                          },
                          child: ListTile(
                            title: Text("${controller.news[index].title}"),
                            subtitle: Text("${controller.news[index].brief}"),
                            trailing:  Icon(Icons.arrow_forward_ios,color: mainColor,),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
    )),
    );
  }
}
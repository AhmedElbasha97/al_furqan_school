// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/Student/books/controller/book_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: mainColor, // اللون اللي تحبه
        statusBarBrightness: Brightness.light, // اللون اللي تحبه
        statusBarIconBrightness: Brightness.light, // أيقونات status bar
        systemNavigationBarColor: mainColor, // اللون اللي تحبه للشريط السفلي
        systemNavigationBarIconBrightness: Brightness.light, // أيقونات الشريط السفلي
      ),
    );
    return GetBuilder(
      init:  BookController(context),
      builder: (BookController controller) =>  SizedBox(
        width: MediaQuery.of(context).size.width,
        height: ScreenHelper.usableHeight(context),
        child: Scaffold(
          appBar: AppBar(
            iconTheme:  IconThemeData(color: white),
            backgroundColor: mainColor,
          ),
          bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
          body: controller.isLoading
              ?  const Loader():
          controller.hasNoData?
          SafeArea(
            child: RefreshIndicator(
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
                          Image.asset("assets/images/no_books.png"),
                          Text("ليس هناك كتب متوفره الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                )),
          ):  RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
                child: ListView.separated(
                    itemCount: controller.books.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () async {
                            controller.launchURL(context, index);
                          },
                          title: Text("${controller.books[index].title}"),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
              ),
        ),
      ),
    );
  }
}

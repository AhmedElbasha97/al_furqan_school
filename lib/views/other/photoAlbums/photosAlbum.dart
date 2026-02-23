// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/other/photoAlbums/controller/photos_albuns_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhotosAlbum extends StatelessWidget {
   const PhotosAlbum({Key? key}) : super(key: key);
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
      init:  PhotosAlbumsController(context),
      builder: (PhotosAlbumsController controller) =>   SizedBox(
        width: MediaQuery.of(context).size.width,
        height: ScreenHelper.usableHeight(context),
        child: Scaffold(
            appBar: AppBar(

                iconTheme:  IconThemeData(color: white),
                backgroundColor: mainColor,

              title: Text(controller.title),
            ),
            bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
            body: controller.isLoading
                ?const Loader()
                : controller.hasNoData?
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
                            Image.asset("assets/images/no_photos.png"),
                            Text("ليس هناك صور متاحه لعرضها لهذا الالبوم",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                  )),
            ):  RefreshIndicator(
                onRefresh: () async {
                  controller.getData();
                },
                  child: ListView.builder(
                      itemCount: controller.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("${controller.list[index].img}"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(15))),
                          ),
                        );
                      }),
                )),
      ),
    );
  }
}

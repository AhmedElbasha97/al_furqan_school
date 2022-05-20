// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/other/photoAlbums/controller/photos_albuns_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotosAlbum extends StatelessWidget {
   const PhotosAlbum({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  PhotosAlbumsController(context),
      builder: (PhotosAlbumsController controller) =>   Scaffold(
          appBar: AppBar(

              iconTheme:  IconThemeData(color: white),
              backgroundColor: mainColor,

            title: Text(controller.title),
          ),
          body: controller.isLoading
              ? const Loader()
              : controller.hasNoData?
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
                        Image.asset("assets/images/no_photos.png"),
                        Text("ليس هناك صور متاحه لعرضها لهذا الالبوم",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                ),
              )):  RefreshIndicator(
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
    );
  }
}

// ignore_for_file: file_names
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/views/other/photoAlbums/photosAlbum.dart';
import 'package:get/get.dart';
import 'controller/album_screen_controller.dart';

class AlbumsScreen extends StatelessWidget {

  const AlbumsScreen({Key? key,}) : super(key: key);
  @override

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init:  AlbumController(),
      builder: (AlbumController controller) =>  Scaffold(
          appBar: AppBar(
            iconTheme:  IconThemeData(color: white),
            backgroundColor: mainColor,
          ),
          body: controller.isLoading
              ?  const Loader()
              :controller.hasNoData?
          RefreshIndicator(
              onRefresh: () async {
                controller.getGalleryData();
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
                        Image.asset(controller.isImg?"assets/images/no_photos.png":"assets/images/no_videos.png"),
                        Text(controller.isImg?"ليس هناك صور متاحه فى الالبوم الصور":"ليس هناك فيديو متاح فى الالبوم الفيديوهات",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                ),
              )):
          RefreshIndicator(
            onRefresh: () async {
              controller.getGalleryData();
            },
                child: ListView.builder(
                    itemCount: controller.isImg ? controller.list.length : controller.listVideos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              if (controller.isImg) {
                                Get.to(()=>const PhotosAlbum(),arguments: [controller.list[index].id,controller.list[index].title]);
                              } else {
                                if (controller.isImg == false) {
                                 controller.launchURL(context, index);
                                }
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${controller.isImg ? controller.list[index].img : controller.listVideos[index].img}"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(15))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 200,
                                  decoration:  BoxDecoration(
                                      color: mainColor,
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 200,
                                      child: Text(
                                        "${controller.isImg ? controller.list[index].title : controller.listVideos[index].title}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style:  TextStyle(color:white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),
              )),
    );
  }
}

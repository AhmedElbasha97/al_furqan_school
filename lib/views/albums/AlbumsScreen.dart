// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/appData/contact_us/controller/contact_us_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/photoAlbum.dart';
import 'package:al_furqan_school/models/AppInfo/videos.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:al_furqan_school/views/other/photosAlbum.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/album_screen_controller.dart';

class AlbumsScreen extends StatefulWidget {
 final bool isImg;
  const AlbumsScreen({Key? key, this.isImg = true}) : super(key: key);
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
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
              : ListView.builder(
                  itemCount: widget.isImg ? controller.list.length : controller.listVideos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (widget.isImg) {
                              pushPage(
                                  context,
                                  PhotosAlbum(
                                    id: controller.list[index].id,
                                    isImg: widget.isImg,
                                    title: controller.list[index].title,
                                  ));
                            } else {
                              if (widget.isImg == false) {
                                if (await canLaunch(
                                    "${controller.listVideos[index].link}")) {
                                  await launch("${controller.listVideos[index].link}");
                                } else {
                                  throw 'Could not launch ${controller.listVideos[index].link}';
                                }
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
                                          "${widget.isImg ? controller.list[index].img : controller.listVideos[index].img}"),
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
                                      "${widget.isImg ? controller.list[index].title : controller.listVideos[index].title}",
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
                  })),
    );
  }
}

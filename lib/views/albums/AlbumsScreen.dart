// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/photoAlbum.dart';
import 'package:al_furqan_school/models/AppInfo/videos.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:al_furqan_school/views/other/photosAlbum.dart';
import 'package:url_launcher/url_launcher.dart';

class AlbumsScreen extends StatefulWidget {
 final bool isImg;
  const AlbumsScreen({Key? key, this.isImg = true}) : super(key: key);
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  bool isLoading = true;
  List<PhotoAlbum> list = [];
  List<Videos> listVideos = [];

  getData() async {
    if (widget.isImg) {
      list = await AlbumsService().getphotoAlbums();
    } else {
      listVideos = await AlbumsService().getVideoAlbums();
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: isLoading
            ?  Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                  backgroundColor: white,
                ),
              )
            : ListView.builder(
                itemCount: widget.isImg ? list.length : listVideos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          if (widget.isImg) {
                            pushPage(
                                context,
                                PhotosAlbum(
                                  id: list[index].id,
                                  isImg: widget.isImg,
                                  title: list[index].title,
                                ));
                          } else {
                            if (widget.isImg == false) {
                              if (await canLaunch(
                                  "${listVideos[index].link}")) {
                                await launch("${listVideos[index].link}");
                              } else {
                                throw 'Could not launch ${listVideos[index].link}';
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
                                        "${widget.isImg ? list[index].img : listVideos[index].img}"),
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
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    "${widget.isImg ? list[index].title : listVideos[index].title}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }));
  }
}

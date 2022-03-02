// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/models/AppInfo/photo.dart';
import 'package:al_furqan_school/models/AppInfo/videos.dart';
import 'package:al_furqan_school/services/albums.dart';

class PhotosAlbum extends StatefulWidget {
  final String? id;
  final String? title;
  final bool isImg;
   const PhotosAlbum({Key? key, this.id, this.title, this.isImg = true}) : super(key: key);
  @override
  _PhotosAlbumState createState() => _PhotosAlbumState();
}

class _PhotosAlbumState extends State<PhotosAlbum> {
  bool isLoading = true;
  List<Photo> list = [];
  List<Videos> listVideos = [];

  getData() async {
    if (widget.isImg) {
      list = await AlbumsService().getphotoAlbum(widget.id);
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

          title: Text("${widget.title}"),
        ),
        body: isLoading
            ?  Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                  backgroundColor: white,
                ),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${list[index].img}"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(15))),
                    ),
                  );
                }));
  }
}

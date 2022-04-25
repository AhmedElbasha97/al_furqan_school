import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/AppInfo/photo.dart';
import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';

import 'package:dio/dio.dart';


class AlbumsService {
  String baseURL = "https://alforqanschools.sch.qa/site/api/";
  String photoAlbums = "gallery.php";
  String videoAlbums = "videos.php";

  Future<List<Gallery>> getphotoAlbums() async {
    List<Gallery> list = [];
    Response response;
    response = await Dio().get(
      baseURL+photoAlbums,
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Gallery.fromJson(element));
    });
    return list;
  }

  Future<List<Videos>> getVideoAlbums() async {
    List<Videos> list = [];
    Response response;
    response = await Dio().get(
      baseURL+videoAlbums,
    );
    var data = response.data ?? [];
    data.forEach((element) {
      list.add(Videos.fromJson(element));
    });
    return list;
  }

  Future<List<Photo>> getphotoAlbum(String? id) async {
    List<Photo> list = [];
    Response response;
    response = await Dio().get(
      "${baseURL + photoAlbums}?gid=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Photo.fromJson(element));
    });
    return list;
  }

  Future<List<Photo>> getVideoAlbum(String id) async {
    List<Photo> list = [];
    Response response;
    response = await Dio().get(
      "$videoAlbums?gid=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Photo.fromJson(element));
    });
    return list;
  }
}

// ignore_for_file: unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/AppInfo/photo.dart';
import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsService {
  String photoAlbums = "${baseUrl}gallery.php";
  String photoAlbumsDetailed = "${baseUrl}gallery2.php";
  String videoAlbums = "${baseUrl}videos.php";

  Future<List<Gallery>> getPhotoAlbums() async {
    List<Gallery> list = [];
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var type = prefs.getString("schoolType")??""; print( photoAlbums+"?school_type=$type");
    response = await Dio().get(

     photoAlbums+"?school_type=$type",
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var type = prefs.getString("schoolType")??"";
    response = await Dio().get(
      videoAlbums+"?school_type=$type",
    );
    var data = response.data ?? [];
    data.forEach((element) {

      list.add(Videos.fromJson(element));
    });
    return list;
  }

  Future<List<Photo>?>? getPhotoAlbum(String? id) async {
    List<Photo> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("$photoAlbumsDetailed?gid=$id");
    Response response;
    response = await Dio().get(
      "$photoAlbumsDetailed?gid=$id",
    );
    var data = response.data;
    if (data != null) {
      data.forEach((element) {
        list.add(Photo.fromJson(element));
      });
      return list;
    }else{
      return null;
    }
  }
}

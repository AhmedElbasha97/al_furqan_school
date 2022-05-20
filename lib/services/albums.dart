import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/AppInfo/photo.dart';
import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsService {
  String photoAlbums = "${baseUrl}gallery.php";
  String videoAlbums = "${baseUrl}videos.php";

  Future<List<Gallery>> getPhotoAlbums() async {
    List<Gallery> list = [];
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var type = prefs.getString("schoolType")??"";
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

  Future<List<Photo>> getPhotoAlbum(String? id) async {
    List<Photo> list = [];
    Response response;
    response = await Dio().get(
      "$photoAlbums?gid=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Photo.fromJson(element));
    });
    return list;
  }

}

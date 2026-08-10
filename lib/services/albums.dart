import 'package:al_furqan_school/models/AppInfo/photo.dart';
import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:al_furqan_school/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsService {
  Future<List<Gallery>> getPhotoAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    final type = prefs.getString('schoolType') ?? '';
    try {
      final response = await ApiClient.instance.dio.get(
        'gallery.php',
        queryParameters: {'school_type': type},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Gallery.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Videos>> getVideoAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    final type = prefs.getString('schoolType') ?? '';
    try {
      final response = await ApiClient.instance.dio.get(
        'videos.php',
        queryParameters: {'school_type': type},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Videos.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Photo>> getPhotoAlbum(String? id) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'gallery.php',
        queryParameters: {'gid': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Photo.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }
}

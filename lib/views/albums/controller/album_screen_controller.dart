import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController{
  List<Gallery> list = [];
  List<Videos> listVideos = [];
  bool isLoading = true;
  @override
  void onInit() {
    getGalleryData();
    super.onInit();
  }
  getGalleryData() async {
      list = await AlbumsService().getphotoAlbums();
      listVideos = await AlbumsService().getVideoAlbums();
    isLoading = false;
    update();

  }
}
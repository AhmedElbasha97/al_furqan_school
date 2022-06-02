import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/gallery_model.dart';
import 'package:al_furqan_school/models/new/videos_model.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AlbumController extends GetxController{
  List<Gallery> list = [];
  List<Videos> listVideos = [];
  bool isImg = Get.arguments[0];
  bool isLoading = true;
  bool hasNoData = false;
  @override
  Future<void> onInit() async {
    await getGalleryData();
    super.onInit();
  }
  launchURL(context, index) async {
    if ( await launchUrl(Uri.parse(listVideos[index].link??""),mode: LaunchMode.externalApplication)) {

      showTheDialog(context, "للا يمكن فتح هذا الفيديو", "هذا الفيديو غير متاح");
      throw 'Could not launch ${listVideos[index].link}';

    }
  }
  getGalleryData() async {
    isLoading = true;
    update();
   isImg? list = await AlbumsService().getPhotoAlbums()
      :listVideos = await AlbumsService().getVideoAlbums();
   if(isImg){
     if(list.isEmpty){
       hasNoData = true;
     }else{
       hasNoData = false;
     }
   }else{
     if(listVideos.isEmpty){
       hasNoData = true;
     }else{
       hasNoData = false;
     }
   }
    isLoading = false;
    update();

  }
}
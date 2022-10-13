import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/news_details.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsController extends GetxController{
  bool isLoading = true;
  bool isOffline = false;
  late NewsDetailsModel news ;
  bool noPhotos= false;
  final BuildContext context;
  List<String> photos=[];
  int counter = 0;
  var id =Get.arguments;
  @override
  NewsDetailsController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    super.onInit();
  update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  launchURL(context) async {
    if (await launchUrl(Uri.parse(news.video??""))) {

    showTheDialog(context, "لايمكن عرض الفيديو", "ليس متوفر فيديو لهذا الخبر");
    throw 'Could not launch ${news.video}';

    }
  }
  detectPhotos(){
  if(news.image!=""){
  photos.add(news.image!);
  }else if(news.image2!=""){
    photos.add(news.image2!);
  }else if(news.image3!=""){
    photos.add(news.image3!);
  }else if(news.image4!=""){
    photos.add(news.image4!);
  }else if(news.image5!=""){
    photos.add(news.image5!);
  }else if(news.image6!=""){
    photos.add(news.image6!);
  }else if(news.image7!=""){
    photos.add(news.image7!);
  }else if(news.image8!=""){
    photos.add(news.image8!);
  }else{
    noPhotos =true;
  }
  }
  getData() async {
    news = await AppInfoService().getNewsDetailsData(id[0]??"1");
    detectPhotos();
    isLoading = false;
    update();
  }
}
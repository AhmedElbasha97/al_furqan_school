// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/new/news.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends GetxController{
  bool isLoading = true;
  bool hasNoData=false;
  bool isOffline = false;
  List<NewsModel> news = [];
  final context;
  NewsController(this.context);
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
  getData() async {
    isLoading=true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolType =  prefs.getString("schoolType");
    news = (await AppInfoService().getNewsData(schoolType))!;
    if(news==[]){
      hasNoData=true;
    }
    isLoading = false;
   update();
  }

}
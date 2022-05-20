import 'package:al_furqan_school/models/new/news.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends GetxController{
  bool isLoading = true;
  bool hasNoData=false;
  List<NewsModel> news = [];
  final context;
  NewsController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  getData() async {
    isLoading=true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolType =  prefs.getString("schoolType");
    news = await AppInfoService().getNewsData(schoolType);
    if(news==[]){
      hasNoData=true;
    }
    isLoading = false;
   update();
  }

}
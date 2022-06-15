import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/Student/book.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BookController extends GetxController{
  bool isLoading = true;
  bool isOffline = false;
  List<Books> books = [];
  bool hasNoData = false;
  final BuildContext context;
  BookController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
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
  launchURL(context, index) async {
    if (await launchUrl(Uri.parse(books[index].file??""))) {

      showTheDialog(context, "لا يمكن تحميل هذا الملف", "لا يوجد ملف متاح للتحميل ");
      throw 'Could not launch ${books[index].file}';

    }
  }
  getData() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    books = await LoggedUser().getBooks(id: id);
    if(books.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
   update();
  }
}
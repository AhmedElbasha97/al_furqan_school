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
  List<Books> books = [];
  bool hasNoData = false;
  final BuildContext context;
  BookController(this.context);
  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  launchURL(context, index) async {
    if (await canLaunchUrl(Uri.parse(books[index].file ??""))) {
      await launchUrl(Uri.parse(books[index].file??""));
    } else {
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
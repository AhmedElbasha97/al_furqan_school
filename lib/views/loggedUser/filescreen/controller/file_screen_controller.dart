import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/files.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileScreenController extends GetxController{
  bool isLoading = true;
  List<Files> files = [];
  bool isOffline = false;
  bool hasNoData = false;
  final BuildContext context;
  FileScreenController(this.context);
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
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    files = await LoggedUser().getFiles(id: id);
    if(files.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
   update();
  }
}
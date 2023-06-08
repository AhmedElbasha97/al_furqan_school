// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, avoid_print, deprecated_member_use, sized_box_for_whitespace, use_build_context_synchronously

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/Student/scedules_model.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SchedulesController extends GetxController{
  final BuildContext context;
  SchedulesController(this.context);
  List<Category?> categories = [];

  List<Category?> levels = [];
  SchedulesModel photoLink = SchedulesModel();
  List<Category?> Class = [];
  bool isOffline = false;
  bool imageLoading = true;
  bool categoryLoading = false;
  bool levelLoading = false;
  bool classLoading = false;
  Category? selectedCategory;
  Category? selectedLevel;
  Category? selectedClass;
  Category? selectCategory = Category(ctgName: "اختار القسم");
  Category? selectLevel = Category(ctgName: "اختار المرحلة");
  Category? selectClass = Category(ctgName: "اختار الفصل");
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getCatgories();
    }
    super.onInit();
  }

  selectingCategory(value) {
    selectCategory = value;
    selectedCategory = value;
    levelLoading = true;
    getLevels();
    update();
  }
  selectingLevels (value) {
    selectLevel = value;
    selectedLevel = value;
    classLoading = true;
    getClass();
    update();
  } selectingClass (value) async {
    selectClass = value;
    selectedClass = value;
    await getPhotos(selectedClass?.id);
    update();
  }
  getPhotos(String? id) async {
  photoLink = (await LoggedUser().getSchedules(classId: id))!;
  imageLoading = false;
  update();
  }
  downloadImage() async {
  String savename = "schedules.png";
  String path ="";
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if(statuses[Permission.storage]!.isGranted){
      Directory dir = Directory('/storage/emulated/0/Download');
      if(dir != null){
        String savePath = "${dir.path}/$savename";
        path = "${dir.path}/$savename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(
              photoLink.img??"",
              savePath,
              onReceiveProgress: (received, total) {
                if (total != -1) {
                  print("${(received / total * 100).toStringAsFixed(0)}%");
                  //you can build progressbar feature too
                }
              });
          print("Image is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    }else{
      print("No permission to read and write.");
    }


   final snackBar = SnackBar(

     content:  Container(
       height: 200,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children:  [
           const Padding(
             padding: EdgeInsets.all(8.0),
             child: Icon(Icons.file_copy,color: Colors.white,),
           ),
           Row(
             children: [
               const Text('اسم الملف:'),
               Text(savename,),
             ],
           ),
           const Text("تم تحميله في ملف مساره هو:",textDirection: TextDirection.rtl,),

           Text(path,),

         ],
       ),
     ),
   );

   ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  getCatgories() async {
    categories = await TeacherService().getCategories();
    categories.add(selectCategory);
    categoryLoading = false;
    getLevels();
    update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getCatgories();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  getLevels() async {
    levels = await TeacherService().getLevels(id: selectedCategory!.id);
    levels.add(selectLevel);
    levelLoading = false;
    update();
  }
  getClass() async {
    Class = await TeacherService().getLevels(id: selectedLevel!.id);
    Class.add(selectClass);
    classLoading = false;
    update();
  }
}
import 'dart:io';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/Student/scedules_model.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'dart:typed_data';

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
  bool isDownloading = false;
  bool isFileDownloaded = false;

  String? lastSavedFilePath;
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getCatgories();
    }
    super.onInit();
  }
  Future<void> checkIfFileExists() async {
    if (lastSavedFilePath == null) {
      isFileDownloaded = false;
      update();
      return;
    }

    File file = File(lastSavedFilePath!);
    isFileDownloaded = await file.exists();
    update();
  }
  String getFileName(String filePath){
    return filePath.split('/').last;
  }
  Future<bool> saveFile() async {
    isDownloading = true;
    update();

    try {
      String? fileUrl = photoLink.img;
      if (fileUrl == null || fileUrl.isEmpty) {
        isDownloading = false;
        update();
        debugPrint("❌ No file URL provided");
        return false;
      }

      String fileName = getFileName(fileUrl);

      final response = await Dio().get(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      var fileBytes = Uint8List.fromList(response.data);

      final res = await FileSaver.instance.saveFile(
        name: fileName.split('.').first,
        bytes: fileBytes,
        mimeType: MimeType.other,
      );
      isDownloading = false;
      update();

      if (res != null) {
        lastSavedFilePath = res;
        checkIfFileExists();
        debugPrint(res);// هنا بنخزن المسار المؤقت
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                Localizations.localeOf(context).languageCode == "en"
                    ? "✅ File saved successfully"
                    : "✅ تم حفظ الملف بنجاح",
              ),
            ),
          );
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("❌ Error saving file: $e");
      isDownloading = false;
      update();
      return false;
    }
  }
  Future<void> openDownloadedFile() async {
    if (lastSavedFilePath == null) {
      debugPrint("❌ No saved file to open");
      return;
    }

    final result = await OpenFile.open(lastSavedFilePath!);
    debugPrint("📂 Open result: ${result.message}");
  }
  void selectingCategory(dynamic value) {
    selectCategory = value;
    selectedCategory = value;
    levelLoading = true;
    getLevels();
    update();
  }
  void selectingLevels(dynamic value) {
    selectLevel = value;
    selectedLevel = value;
    classLoading = true;
    getClass();
    update();
  } Future<void> selectingClass(dynamic value) async {
    selectClass = value;
    selectedClass = value;
    await getPhotos(selectedClass?.id);
    update();
  }
  Future<void> getPhotos(String? id) async {
  photoLink = (await LoggedUser().getSchedules(classId: id))!;
  imageLoading = false;
  update();
  }

  Future<void> getCatgories() async {
    categories = await TeacherService().getCategories();
    categories.add(selectCategory);
    categoryLoading = false;
    getLevels();
    update();
  }
  Future<void> refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getCatgories();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  Future<void> getLevels() async {
    levels = await TeacherService().getLevels(id: selectedCategory!.id);
    levels.add(selectLevel);
    levelLoading = false;
    update();
  }
  Future<void> getClass() async {
    Class = await TeacherService().getLevels(id: selectedLevel!.id);
    Class.add(selectClass);
    classLoading = false;
    update();
  }
}
// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, sized_box_for_whitespace, avoid_print, annotate_overrides

import 'dart:io';

import 'package:al_furqan_school/globals/helpers.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerController extends GetxController{
  bool isLoading = true;
  bool hasNoData = false;
  bool isOffline = false;
  int currentPage = 0 ;
  late PDFDocument document;
  var filePath = Get.arguments[0];
  var fileTitle =Get.arguments[1];
  final BuildContext context;
  PdfViewerController(this.context);
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    print(filePath);
    super.onInit();
    if(!isOffline){
      await downloadDocument();
    }
    downloadDocument();
    update();
  }
  downloadDocument() async {
    document = await PDFDocument.fromURL(
        filePath);
    isLoading = false;
    update();
  }

  hasNoDataFunc(){
    hasNoData = true;
    update();
  }

  stopLoading(){
    isLoading = false;
    update();
  }

  Future<bool> saveFile() async {
    _hasAcceptedPermissions();
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
         directory = Platform.isAndroid
            ? await getExternalStorageDirectory() //FOR ANDROID
            : await getApplicationSupportDirectory(); //FOR iOS
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/Al-Furqan_School";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileTitle");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {

          await Dio().download(
            filePath,
            saveFile.path,
          );
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
                    Text(fileTitle??"",),
                  ],
                ),
                const Text("تم تحميله في ملف مساره هو:",textDirection: TextDirection.rtl,),

                Text(newPath,),

              ],
            ),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  launchURL(context) async {
    if ( !await launchUrl(Uri.parse(filePath??""),mode: LaunchMode.externalApplication)) {

      showTheDialog(context, "لايمكن عرض الفيديو", "ليس متوفر فيديو");
      throw 'Could not launch $filePath';

    }
  }
  Future<bool> _hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage) &&
          // access media location needed for android 10/Q
          await _requestPermission(Permission.accessMediaLocation) &&
          // manage external storage needed for android 11/R
          await _requestPermission(Permission.manageExternalStorage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(Permission.photos)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }}
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await downloadDocument();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
}
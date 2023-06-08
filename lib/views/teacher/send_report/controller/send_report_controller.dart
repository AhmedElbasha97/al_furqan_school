// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/models/teacher/student.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendReportController extends GetxController{

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController msgController =  TextEditingController();
  final FocusNode msgNode =  FocusNode();
  Category? selectClass = Category(ctgName: "اختار الفصل");
  Category? selectedClass;
  bool isOffline = false;

  List<Category?> categories = [];
  List<Category?> Class = [];
  List<Category?> levels = [];
  List<Student?> student = [];

  bool isLoading = false;
  bool categoryloading = true;
  bool levelLoading = false;
  bool studentsLoading = false;
  bool classLoading = false;
  Category? selectCatogory = Category(ctgName: "اختار القسم");
  Category? selectLevel = Category(ctgName: "اختار المرحلة");
  Student? selectStudent = Student(name: "اختار طالب");

  Category? selectedCatogory;
  Category? selectedLevel;
  Student? selectedStudent;
  final BuildContext context;
  SendReportController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getCatgories();
    }
    super.onInit();
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
  getClass() async {
    Class = await TeacherService().getLevels(id: selectedLevel!.id);
    Class.add(selectClass);
    classLoading = false;
    update();
  }

  selectingClass (value) {
    if(!isOffline) {
      selectClass = value;
      selectedClass = value;
      studentsLoading = true;
      getStudent();
      update();
    }else{
      showTheDialog(context,"قم باختيار مره اخرى","حاول الاتصال مره اخرى بشبكه الانترنت وقوم باختيار مره اخرى");
    }
    }
    selectingCategory(value) {
      if(!isOffline) {
        selectCatogory = value;
        selectedCatogory = value;
        levelLoading = true;
        getLevels();
        update();
      }else{
        showTheDialog(context,"قم باختيار مره اخرى","حاول الاتصال مره اخرى بشبكه الانترنت وقوم باختيار مره اخرى");

      }
    }
    String? validatorMassage(value) {
      if ((value!.isEmpty)&&(value!.replaceAll(' ', '').isEmpty)&&(value!.isNumericOnly)) {
        return "التقرير مطلوبة";
      }
      return null;
    }
    selectingLevels (value) {
      if(!isOffline) {
      selectLevel = value;
      selectedLevel = value;
      classLoading = true;
      getClass();
      update();
      }else{
        showTheDialog(context,"قم باختيار مره اخرى","حاول الاتصال مره اخرى بشبكه الانترنت وقوم باختيار مره اخرى");

      }
    }
    selectingStudent(value) {
      if(!isOffline) {
      selectStudent = value;
      selectedStudent = value;
      update();
      }else{
        showTheDialog(context,"قم باختيار مره اخرى","حاول الاتصال مره اخرى بشبكه الانترنت وقوم باختيار مره اخرى");

      }
    }
    getCatgories() async {
      categories = await TeacherService().getCategories();
      categories.add(selectCatogory);
      categoryloading = false;
      update();
    }

    getLevels() async {
      levels = await TeacherService().getLevels(id: selectedCatogory!.id);
      levels.add(selectLevel);
      levelLoading = false;
      update();
    }

    getStudent() async {
      student = await TeacherService().getStudents(id: selectedClass!.id);
      student.add(selectStudent);
      studentsLoading = false;
      update();
    }

    void unFocus() {
      msgNode.unfocus();
      update();
    }

    sendMessage(context) async {
      if(!isOffline) {
      if (formKey.currentState!.validate()) {
        if(selectCatogory!=null){if(selectedLevel!=null){
          if (selectedStudent != null) {
            isLoading = true;

            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? id = prefs.getString("id");
            var done = await TeacherService().sendReport(
                id: id, msg: msgController.text, studentId: selectedStudent!.id);
            if (done) {
              doneMassage(context,"تم ارسال التقرير بنجاح", Icon(Icons.check_circle_outline_rounded ,color: mainColor,size: 90,),);
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });

            } else {
              doneMassage(context,"لم يتم ارسال التقرير حاول مره اخرى لاحقاً", Icon(Icons.clear ,color: mainColor,size: 90,),);
              Future.delayed(const Duration(milliseconds: 5000), () {
                Navigator.pop(context);

              });
            }
          }
        }else{
          showTheDialog(context, "لا تستطيع إرسال التقرير", "يجب عليك اختيار الطالب");
        }}else{
          showTheDialog(context, "لا تستطيع إرسال التقرير", "يجب عليك اختيار المستوى");
        }}else{
        showTheDialog(context, "لا تستطيع إرسال التقرير", "يجب عليك اختيار القسم");
      }
      }else{
        showTheDialog(context,"لا يمكن ارسال التقرير","حاول الاتصال مره اخرى بشبكه الانترنت و قوم بإرسال التقرير مره اخرى");

      }
    }
    Future<void> doneMassage(context,String title, Icon icon) async {
      return showDialog<void>(

        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return StatefulBuilder(builder: (context, StateSetter setState) {
                return Dialog(
                  child: Container(
                      color: white,
                      width: MediaQuery.of(context).size.width*0.1,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child:  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon,
                            Text(title,style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),
                      )
                  ),
                );
              });
            },
          );
        },
      );
    }
  }




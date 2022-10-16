import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/models/teacher/student.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:al_furqan_school/views/homescreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentMessageTeacherController extends GetxController{
  bool isStageLoading = true;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   final TextEditingController titleController =  TextEditingController();
  final TextEditingController msgController =  TextEditingController();

  final FocusNode titleNode =  FocusNode();
  final FocusNode msgNode =  FocusNode();

  String? type = 'اختار المرسل له';
  String selected = "";
  List<Category?> categories = [];
  List<Category?> levels = [];
  List<Category?> Class = [];
  List<Student?> student = [];
  List<Student?> parent = [];
  bool categoryloading = false;
  bool levelLoading = false;
  bool classLoading = false;
  bool studentsLoading = false;
  Category? selectedCatogory;
  Category? selectedLevel;
  Category? selectedClass;
  Student? selectedStudent;
  Student? selectedParent;
  Student? allParent = Student(parent: "كل اولياء الامور فى الفصل",id:"allparent");
  Category? selectCatogory = Category(ctgName: "اختار القسم");
  Category? selectLevel = Category(ctgName: "اختار المرحلة");
  Category? selectClass = Category(ctgName: "اختار الفصل");
  Student? selectStudent = Student(name: "اختار طالب");
  Student? selectParent = Student(parent: "اختار ولى الامر");
  final BuildContext context;
  bool isOffline = false;

  SentMessageTeacherController(this.context);
  @override
  Future<void> onInit() async {
    isOffline = !await connectivityChecker();

    super.onInit();
  update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){

    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }

  chooseType (value) {
    if(!isOffline){
    type = value;
    selected = type != 'الادارة' ? "other" : "admin";
    if(type != "admin"){
      categoryloading=true;
      update();
      getCatgories();
    }
    update();}else{
      showTheDialog(context,"قم باختيار مره اخرى","حاول الاتصال مره اخرى بشبكه الانترنت وقوم باختيار مره اخرى");

    }
  }

  selectingCategory(value) {
    selectCatogory = value;
    selectedCatogory = value;
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
  } selectingClass (value) {
    selectClass = value;
    selectedClass = value;
    studentsLoading = true;
    getUserData();
    update();
  }
  selectingStudent(value) {
    selectStudent = value;
    selectedStudent = value;
    update();
  }  selectingParent(value) {
    selectedParent = value;
    selectParent = value;
    update();
  }
  getCatgories() async {
    categories = await TeacherService().getCategories();
    categories.add(selectCatogory);
    categoryloading = false;
    getLevels();
    update();
  }

  getLevels() async {
    levels = await TeacherService().getLevels(id: selectedCatogory!.id);
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

  getUserData() async {
    student = await TeacherService().getStudents(id: selectedClass!.id);
    parent = await TeacherService().getStudents(id: selectedClass!.id);
    student.add(selectStudent);
    parent.add(selectParent);
    parent.add(allParent);
    studentsLoading = false;
    update();
  }
  String? validatorMassage(value) {
    if ((value!.isEmpty)&&(value!.replaceAll(' ', '').isEmpty)&&(value!.isNumericOnly)) {
      return "الرسالة مطلوبة";
    }
    return null;
  }
  String? validatorTitle(value) {
    if ((value!.isEmpty)&&(value!.replaceAll(' ', '').isEmpty)&&(value!.isNumericOnly)) {
      return "العنوان مطلوب";
    }
    return null;
  }

  sendMessage(context) async {
    if(!isOffline){
    if(selected!=null){
      if(selectedCatogory!=null){
        if(selectedLevel!=null) {
          if(selectClass!=null) {
            if((selectedParent!=null)||(selectStudent!=null)
            ) {
              if (formKey.currentState!.validate()) {
                isStageLoading = true;
                update();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? id = prefs.getString("id");
                String? done = "";
                if(type=="admin"){
                 done = await TeacherService().sendMessages(id: id,type: "admin",text: msgController.text,studentId: "0",title: titleController.text);
                }else if(selectedParent!=null){
                  done = await TeacherService().sendMessages(id: id,type: "parent",text: msgController.text,parentId: selectedParent?.id,title: titleController.text);
                }else{
                  done = await TeacherService().sendMessages(id: id,type: "student",text: msgController.text,studentId: selectedStudent?.id,title: titleController.text);
                }
                isStageLoading = false;
                update();
                if (done == "true") {
                  doneMassage(context, "تم ارسال الرساله بنجاح", Icon(
                    Icons.check_circle_outline_rounded, color: mainColor,
                    size: 90,),);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Get.replace(() => const HomeScreen());
                  });
                } else {
                  doneMassage(context, "لم يتم ارسال الرساله حاول مره اخرى",
                    Icon(Icons.clear, color: mainColor, size: 90,),);
                  Future.delayed(const Duration(milliseconds: 5000), () {
                    Navigator.pop(context);
                  });
                }
              }
            }else{
              showTheDialog(context, "يجب اختيار الشخص", "لا يمكن ارسال الرساله الا عند اختيار الشخص");

            }
          }else{
            showTheDialog(context, "يجب اختيار الفصل", "لا يمكن ارسال الرساله الا عند اختيار الفصل");

          }
          }else{
          showTheDialog(context, "يجب اختيار الصف", "لا يمكن ارسال الرساله الا عند اختيار الصف");

        }
        } else{
      showTheDialog(context, "يجب اختيار الجهه", "لا يمكن ارسال الرساله الا عند اختيار الجهه");
    }
    }else{
  showTheDialog(context, "يجب اختيار الجهه المرسل اليها", "لا يمكن ارسال الرساله الا عند اختيار الجهه المرسل اليها");
  }}else{
      showTheDialog(context,"لا يمكن إرسال الرساله","حاول الاتصال مره اخرى بشبكه الانترنت و قوم بإرسال الرساله مره اخرى");

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
  void unFocus() {
    titleNode.unfocus();
    msgNode.unfocus();
    update();
  }
}
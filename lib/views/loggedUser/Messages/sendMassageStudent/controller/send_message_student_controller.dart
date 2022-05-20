import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teachers.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/views/homescreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMessageStudentController extends GetxController{
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int id=Get.arguments[0];
  final TextEditingController titleController =  TextEditingController();
  final TextEditingController msgController =  TextEditingController();
  final FocusNode titleNode =  FocusNode();
  final FocusNode msgNode =  FocusNode();
  String? type = 'اختار المرسل له';
  String selected = "";
  List<Teachers?> teachers = [];
  Teachers? selectedTeacher;
  Teachers? selectTeacher = Teachers(name: "اختر مدرس");
  final BuildContext context;
  SendMessageStudentController(this.context);
  @override
  Future<void> onInit() async {
    await getTeachers();
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
  }

  @override
  void onClose() {
    titleController.text="";
    msgController.text="";
    super.onClose();
  }
  getTeachers() async {
    isLoading = true;
    update();
    teachers = await MessagesService().getTeacher();
    teachers.add(selectTeacher);
    isLoading = false;
    update();
  }
String? validateMessage(value){
  if ((value!.replaceAll(' ', '').isEmpty)&&(value!.isEmpty)&&(value!.isNumericOnly)) {
    return "الرسالة مطلوبة";
  }
  return null;
}

chooseTheTeacher(value){
   selectTeacher = value;
    selectedTeacher = value;
    update();
}

 chooseTheDepartment(value){
     type = value;
     selected = type == 'مدرس' ? "teacher" : "admin";
    update();
   }
   checkDepartmentHasBeenChosen(){
    return selected!="";
   }
   checkTeacherHasBeenChosen(){
    return selectedTeacher!=null;
   }
sendMessage(context) async {
    if(checkDepartmentHasBeenChosen()){
    if(checkTeacherHasBeenChosen()){
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString("id");
      String? done =   id != 1 ? await ParentService().sendMessage(
          teacherId: selectedTeacher == null ? "" : selectedTeacher!.id,
          title: titleController.text,
          msg: msgController.text,
          id: idUser,
          type: selected)
          : await MessagesService().sendMessage(
          teacherId: selectedTeacher == null ? "" : selectedTeacher!.id,
          title: titleController.text,
          msg: msgController.text,
          id: idUser,
          type: selected);
      isLoading = false;
      update();
      if (done == "true") {
        doneMassage(context,"تم ارسال الرساله بنجاح", Icon(Icons.check_circle_outline_rounded ,color: mainColor,size: 90,),);
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.replace(()=> const HomeScreen());
      });

      } else {
        doneMassage(context,"لم يتم ارسال الرساله حاول مره اخرى", Icon(Icons.clear ,color: mainColor,size: 90,),);
        Future.delayed(const Duration(milliseconds: 5000), () {
          Navigator.pop(context);

        });
      }

    }
    }else{
      showTheDialog(context, "يجب اختيار المدرس", "لا يمكن ارسال الرساله الا عند اختيار المدرس");
    }}else{
      showTheDialog(context, "يجب اختيار الجهه المرسل اليها", "لا يمكن ارسال الرساله الا عند اختيار الجهه المرسل اليها");
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
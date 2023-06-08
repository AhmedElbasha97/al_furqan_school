// ignore_for_file: use_build_context_synchronously

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/contactUsService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController =  TextEditingController();
  final TextEditingController msgController =  TextEditingController();
  final TextEditingController phoneController =  TextEditingController();
  bool isLoading = true;
  final FocusNode emailNode =  FocusNode();
  final FocusNode nameNode =  FocusNode();
  final FocusNode msgNode =  FocusNode();
  final FocusNode phoneNode =  FocusNode();
  final formKey = GlobalKey<FormState>();
  final BuildContext context;
  bool isOffline =false;
  ContactUsController(this.context);
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
  unFocus() {
    emailNode.unfocus();
    nameNode.unfocus();
    msgNode.unfocus();
    phoneNode.unfocus();
    update();
  }
  bool emailValidator(String email) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
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
  @override
  void onClose() {
    nameController.text="";
    msgController.text="";
    phoneController.text="";
    emailController.text="";
    super.onClose();
  }
  sendMessage(context) async {
    if(!isOffline) {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();

     var result = await ContactUsService().sendComplain(
          nameController.text ,
          msgController.text ,
          emailController.text ,
          "api_subject",
          phoneController.text );
     if (result == "true") {
       doneMassage(context,"تم ارسال الرساله بنجاح", Icon(Icons.check_circle_outline_rounded ,color: mainColor,size: 90,),);
       Future.delayed(const Duration(milliseconds: 500), () {
         Navigator.pop(context);
         Navigator.pop(context);
       });
     }else{
       doneMassage(context,"لم يتم ارسال الرساله حاول مره اخرى", Icon(Icons.clear ,color: mainColor,size: 90,),);
       Future.delayed(const Duration(milliseconds: 5000), () {
         Navigator.pop(context);
         Navigator.pop(context);
       });
     }
      isLoading = false;
      update();

    } }else{
      showTheDialog(context,"لا يمكن ارسال البينات","حاول الاتصال مره اخرى بشبكه الانترنت و قوم بإرسال البينات مره اخرى");

    }
  }
  String? massageValidator( String? value){

    if (value!.length < 2||value.isEmpty) {
      return "الرسالة مطلوبة";
    }
    return null;

  }
  String? nameValidator(String? value){
    if (value!.isEmpty||value.replaceAll(' ', '').isNumericOnly) {

      return "برجاء ادخال اسمك";
    }
    return null;
  }
  String? emailValidate(String? value){
    if(value == null||!emailValidator(value)){
     return "البريد الالكتروني مطلوب";
    }
    return null;
  }
  String? phoneValidator(String? value){
    if (value!.isEmpty||value.isAlphabetOnly||value.length<3) {
      return "برجاء ادخال رقم هاتفك";
    }
    return null;
  }
}
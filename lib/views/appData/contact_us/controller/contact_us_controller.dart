import 'package:al_furqan_school/services/contactUsService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController =  TextEditingController();
  final TextEditingController msgController =  TextEditingController();
  final TextEditingController phoneController =  TextEditingController();
  bool isLoading = true;
  final FocusNode emailNode =  FocusNode();
  final FocusNode nameNode =  FocusNode();
  final FocusNode msgNode =  FocusNode();
  final FocusNode phoneNode =  FocusNode();
  unFocus() {
    emailNode.unfocus();
    nameNode.unfocus();
    msgNode.unfocus();
    phoneNode.unfocus();
    update();
  }
  bool emailvalidator(String email) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
  sendMessage() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();
      await ContactUsService().sendComplain(
          nameController.text ,
          msgController.text ,
          emailController.text ,
          "",
          phoneController.text );
      isLoading = false;
      update();

    }
  }
  String? massageValidator( String? value){
    if (value!.length < 2) {
      return "الرسالة مطلوبة";
    }
    return null;

  }
  String? nameValidator(String? value){
    if (value!.isEmpty) {
      return "برجاء ادخال اسمك";
    }
    return null;
  }
  String? emailValidate(String? value){
    if(value == null||emailvalidator(value)){
     return "البريد الالكتروني مطلوب";
    }
    return null;
  }
  String? phoneValidator(String? value){
    if (value!.isEmpty) {
      return "برجاء ادخال رقم هاتفك";
    }
    return null;
  }
}
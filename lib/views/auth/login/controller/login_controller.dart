import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool usernameError = false;
  bool passwordError = false;
  bool isServerLoading = false;
  bool isOffline = false;
  String selectedType = "اختر نوع المستخدم";
  String accountType = "";
  final BuildContext context;
  @override
  LoginController(this.context);
  @override
  Future<void> onInit() async {
    super.onInit();
    isOffline = !await connectivityChecker();

  update();
  }
  @override
  void onClose() {
    super.onClose();
    usernameController.text= "";
    passwordController.text="";
}
  validate() async {
    usernameError = usernameController.text.isEmpty;
    passwordError = passwordController.text.isEmpty;
    update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(isOffline){
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  chooseTypeOfUser(String? value){
    accountType = value == "ولي أمر"
        ? "PARENTS"
        : value == "مدرس"
        ? "TEACHER"
        : "STUDENT";
    selectedType=value??"";
    update();
  }
  login(context) async {
    if(!isOffline){if(accountType!="") {
      if (!passwordError && !usernameError) {
        var msg = await AuthService().login(
            password: passwordController.text,
            userName: usernameController.text,
            type: accountType);
        if (msg == "done") {
          return true;
        } else {
          showTheDialog(context,"حدث خطأ أثناء تسجيل الدخول","من فضلك راجع البيانات");
          return false;
        }
      }
    }
    else{
      showTheDialog(context,"لا يمكنك تسجيل الدخول","من فضلك اختار نوع صاحب الحساب");
    }}else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }

    }
}
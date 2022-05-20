import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/authService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool usernameError = false;
  bool passwordError = false;
  bool isServerLoading = false;
  String? selectedType = "اختار نوع المستخدم";
  String accountType = "";
  final BuildContext context;
  @override
  LoginController(this.context);
  @override
  void onInit() {
    super.onInit();
    NotificationServices.checkNotificationAppInForeground(context);
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
  login(context) async {
    if(accountType!="") {
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
    }else{
      showTheDialog(context,"لا يمكنك تسجيل الدخول","من فضلك اختار نوع صاحب الحساب");
    }

    }
}
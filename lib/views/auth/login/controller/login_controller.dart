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
  String? selectedType = "اختار نوع المستخدم";
  String accountType = "";
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
  login() async {
    if (!passwordError && !usernameError) {
      String? msg = await AuthService().login(
          password: passwordController.text,
          userName: usernameController.text,
          type: accountType);
      if (msg == "done") {
        return true;
      } else {
        final snackBar = SnackBar(content: Text(msg!));
        scaffoldKey.currentState!.showSnackBar(snackBar);
        return false;
      }
    }
  }
}
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool usernameError = false;
  bool passwordError = false;
  bool isServerLoading = false;
  bool isOffline = false;

  String? selectedType = 'إختر نوع المستخدم';

  String accountType = '';
  final BuildContext context;

  LoginController(this.context);

  @override
  Future<void> onInit() async {
    super.onInit();
    isOffline = !await connectivityChecker();
    update();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> validate() async {
    usernameError = usernameController.text.isEmpty;
    passwordError = passwordController.text.isEmpty;
    update();
  }

  Future<void> refreshFunction() async {
    isOffline = !await connectivityChecker();
    if (isOffline) {
      // ignore: use_build_context_synchronously
      showTheDialog(context, 'لم يتم الاتصال بالشكل الصحيح',
          'قم التصال بشبكة الانترنت و حاول مره اخرى');
    }
  }

  Future<bool> login(BuildContext ctx) async {
    if (!isOffline) {
      if (accountType != '') {
        if (!passwordError && !usernameError) {
          final msg = await AuthService().login(
            password: passwordController.text,
            userName: usernameController.text,
            type: accountType,
          );
          if (msg == 'done') {
            return true;
          } else {
            // ignore: use_build_context_synchronously
            showTheDialog(ctx, 'حدث خطأ أثناء تسجيل الدخول',
                'من فضلك راجع البيانات');
            return false;
          }
        }
      } else {
        showTheDialog(ctx, 'لا يمكنك تسجيل الدخول',
            'من فضلك اختار نوع صاحب الحساب');
      }
    } else {
      showTheDialog(ctx, 'لم يتم الاتصال بالشكل الصحيح',
          'قم التصال بشبكة الانترنت و حاول مره اخرى');
    }
    return false;
  }
}
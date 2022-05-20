import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/auth/login/controller/login_controller.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/globals/widgets/textFiled.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  LoginController(context),
      builder: (LoginController controller) =>  Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: white,
          appBar: AppBar(
            iconTheme:  IconThemeData(color: white),
            backgroundColor:mainColor ,
            title: Text(
              "${AppLocalizations.of(context)!.translate('login')}",
            ),
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 20)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/logo1.png"),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 20)),
                const Padding(padding: EdgeInsets.only(top: 10)),
                InputFiled(
                  hintText:
                      "${AppLocalizations.of(context)!.translate('userName')}",
                  controller: controller.usernameController,
                ),
                controller.usernameError
                    ? const Text(
                        "please enter your phone number",
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                const Padding(padding: EdgeInsets.only(top: 10)),
                InputFiled(
                  hintText:
                      "${AppLocalizations.of(context)!.translate('password')}",
                  controller: controller.passwordController,
                  inputType: TextInputType.text,
                ),
                controller.passwordError
                    ? const Text(
                        "please enter your password",
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                const Padding(padding: EdgeInsets.only(top: 10)),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: DropdownButton<String>(
                    dropdownColor: white,
                    icon: Container(),
                    value: controller.selectedType,
                    items: <String>[
                      'اختار نوع المستخدم',
                      'ولي امر',
                      'مدرس',
                      'طالب',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color:mainColor,),),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.accountType = value == "ولي امر"
                          ? "PARENTS"
                          : value == "مدرس"
                              ? "TEACHER"
                              : "STUDENT";
                      controller.selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 35)),
                AppBtn(
                  onClick: () async {
                    controller.validate();
                    if(await controller.login(context)){
                      pushPageReplacement(context, const ChooseStateScreen());
                    }
                  },
                  label: "${AppLocalizations.of(context)!.translate('login')}",
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 20))
              ],
            ),
          )),
    );
  }
}

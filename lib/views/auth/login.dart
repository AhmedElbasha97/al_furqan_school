import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/globals/widgets/textFiled.dart';
import 'package:al_furqan_school/services/authService.dart';
import 'package:al_furqan_school/views/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool usernameError = false;
  bool passwordError = false;
  bool isServerLoading = false;
  String? selectedType = "اختار نوع المستخدم";
  String accountType = "";

  validate() async {
    usernameError = usernameController.text.isEmpty;
    passwordError = passwordController.text.isEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
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
                child: Image.asset("assets/images/logoname.jpg"),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                    "${AppLocalizations.of(context)!.translate('userName')}",
                controller: usernameController,
              ),
              usernameError
                  ? const Text(
                      "please enter your phone number",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                    "${AppLocalizations.of(context)!.translate('password')}",
                controller: passwordController,
                inputType: TextInputType.text,
              ),
              passwordError
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
                  value: selectedType,
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
                    accountType = value == "ولي امر"
                        ? "PARENTS"
                        : value == "مدرس"
                            ? "TEACHER"
                            : "STUDENT";
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 35)),
              AppBtn(
                onClick: () async {
                  validate();
                  if (!passwordError && !usernameError) {
                    String? msg = await AuthService().login(
                        password: passwordController.text,
                        userName: usernameController.text,
                        type: accountType);
                    if (msg == "done") {
                      pushPageReplacement(context, const HomeScreen());
                    } else {
                      final snackBar = SnackBar(content: Text(msg!));
                      scaffoldKey.currentState!.showSnackBar(snackBar);
                    }
                  }
                },
                label: "${AppLocalizations.of(context)!.translate('login')}",
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20))
            ],
          ),
        ));
  }
}

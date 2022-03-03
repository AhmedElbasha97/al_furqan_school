import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/contactUsService.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController =  TextEditingController();
  final TextEditingController _msgController =  TextEditingController();
  final TextEditingController _phoneController =  TextEditingController();

  final FocusNode _emailNode =  FocusNode();
  final FocusNode _nameNode =  FocusNode();
  final FocusNode _msgNode =  FocusNode();
  final FocusNode _phoneNode =  FocusNode();

  bool emailvalidator(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      await ContactUsService().sendComplain(
          _nameController.text ,
          _msgController.text ,
          _emailController.text ,
          "",
          _phoneController.text );
      isLoading = false;
      setState(() {});
      popPage(context);
    }
  }

  void unFocus() {
    _emailNode.unfocus();
    _nameNode.unfocus();
    _msgNode.unfocus();
    _phoneNode.unfocus();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color:white ),
          backgroundColor:mainColor ,
          title: Text(
            "${AppLocalizations.of(context)!.translate('callUs')}",
          ),
          automaticallyImplyLeading: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  AppLocalizations.of(context)!.translate('complaientMsg')!,
                  style: const TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  focusNode: _nameNode,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.people),
                    counterText: "",
                    hintText: AppLocalizations.of(context)!.translate('name'),
                    focusedBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainColor, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!
                          .translate('nameError');
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  focusNode: _phoneNode,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    counterText: "",
                    hintText:
                        AppLocalizations.of(context)!.translate('phoneNumber'),
                    focusedBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color:mainColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color:mainColor, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!
                          .translate('phoneError');
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  focusNode: _emailNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    counterText: "",
                    hintText: AppLocalizations.of(context)!.translate('email'),
                    focusedBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainColor, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == "" || emailvalidator(value!) == false) {
                      return AppLocalizations.of(context)!
                          .translate('emailError');
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  validator: (value) {
                    if (value!.length < 2) {
                      return AppLocalizations.of(context)!
                          .translate('MessageError');
                    }
                    return null;
                  },
                  focusNode: _msgNode,
                  controller: _msgController,
                  maxLines: 4,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.translate('typeMsg'),
                    focusedBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainColor, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 40,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.translate('send')!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

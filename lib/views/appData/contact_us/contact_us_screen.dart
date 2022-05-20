import 'package:al_furqan_school/views/appData/contact_us/controller/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';

import 'package:get/get.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
        init:  ContactUsController(context),
        builder: (ContactUsController controller) =>  GestureDetector(
        onTap: () => controller.unFocus(),
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
            key: controller.formKey,
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
                    focusNode: controller.nameNode,
                    controller: controller.nameController,
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
                    validator: controller.nameValidator,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    focusNode: controller.phoneNode,
                    controller: controller.phoneController,
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
                    validator: controller.phoneValidator,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    focusNode: controller.emailNode,
                    controller: controller.emailController,
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
                    validator: controller.emailValidate,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    validator:controller.massageValidator,

                    focusNode: controller.msgNode,
                    controller: controller.msgController,
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
                        controller.sendMessage(context);


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
      ),
    );
  }
}

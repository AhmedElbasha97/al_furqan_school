// ignore_for_file: file_names

import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sendMassageStudent/controller/send_message_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/models/teachers.dart';
import 'package:get/get.dart';

class SendMessageStudentScreen extends StatelessWidget {

   const SendMessageStudentScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  SendMessageStudentController(context),
      builder: (SendMessageStudentController controller) =>
          GestureDetector(
        onTap: () => controller.unFocus(),
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            iconTheme:  IconThemeData(color: white),
            backgroundColor: mainColor,
          ),
          body: controller.isLoading
              ? const Loader()
              : Form(
                  key: controller.formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          AppLocalizations.of(context)!.translate('sendMessage')!,
                          style:  TextStyle(fontSize: 17,color: mainColor,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: controller.titleController,
                          focusNode: controller.titleNode,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon:  Icon(Icons.message,color: mainColor),
                            counterText: "",
                            hintText:
                                AppLocalizations.of(context)!.translate('title'),
                            focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:  mainColor, width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: mainColor, width: 1.0),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: controller.validateMessage
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          focusNode: controller.msgNode,
                          controller: controller.msgController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon:  Icon(Icons.message_rounded,color: mainColor),
                            counterText: "",
                            hintText:
                                AppLocalizations.of(context)!.translate('message'),
                            focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: mainColor, width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: mainColor, width: 1.0),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: controller.validateMessage
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: DropdownButton<String>(
                          icon: Container(),
                          dropdownColor: white,
                          value: controller.type,
                          items: <String>[
                            'اختار المرسل له',
                            'مدرس',
                            'الادارة',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: TextStyle(color: mainColor),),
                            );
                          }).toList(),
                          onChanged:controller.chooseTheDepartment
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: controller.selected == "admin"
                            ? Container()
                            : DropdownButton<Teachers>(
                                icon: Container(),
                                value: controller.selectTeacher,
                                dropdownColor: white,
                                items: controller.teachers.map((Teachers? value) {
                                  return DropdownMenuItem<Teachers>(
                                    value: value,
                                    child: Text("${value!.name}",style: TextStyle(color: mainColor),),
                                  );
                                }).toList(),
                                onChanged:controller.chooseTheTeacher
                              ),
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
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10))),
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

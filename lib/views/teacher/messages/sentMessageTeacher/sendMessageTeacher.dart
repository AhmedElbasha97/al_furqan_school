// ignore_for_file: file_names

import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/messages/sentMessageTeacher/controller/sent_message_teacher_controller.dart';
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
      init: SentMessageTeacherController(context),
      builder: (SentMessageTeacherController controller) => GestureDetector(
        onTap: () => controller.unFocus(),
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(),
          body: Form(
                  key: controller.formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                    children: <Widget>[
                        SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          AppLocalizations.of(context)!.translate('sendMessage')!,
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
                          focusNode: controller.titleNode,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.message),
                            counterText: "",
                            hintText:
                                AppLocalizations.of(context)!.translate('title'),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF184e7a), width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF184e7a), width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator:controller.validatorTitle,
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
                            prefixIcon: const Icon(Icons.message_rounded),
                            counterText: "",
                            hintText:
                                AppLocalizations.of(context)!.translate('message'),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF184e7a), width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF184e7a), width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: controller.validatorMassage,
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
                          value: controller.type,
                          items: <String>[
                            'اختار المرسل له',
                            'مدرس',
                            'الادارة',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged:controller.chooseType,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: controller.selected == "admin"
                            ? Container()
                            :  controller.isLoading
                            ? const Loader(
                          height: 100,
                          width: 300,
                        )
                            :DropdownButton<Teachers>(
                                icon: Container(),
                                value: controller.selectTeacher,
                                items: controller.teachers.map((Teachers? value) {
                                  return DropdownMenuItem<Teachers>(
                                    value: value,
                                    child: Text("${value!.name}"),
                                  );
                                }).toList(),
                                onChanged: controller.chooseTeacher,
                              ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: InkWell(
                            onTap: () {
                              controller.sendMessage(controller);
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

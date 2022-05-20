// ignore_for_file: file_names

import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/send_report/controller/send_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/models/teacher/student.dart';
import 'package:get/get.dart';

class SendReport extends StatefulWidget {
  const SendReport({Key? key}) : super(key: key);

  @override
  _SendReportState createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SendReportController(context),
      builder: (SendReportController controller) =>  GestureDetector(
        onTap: () => controller.unFocus(),
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            iconTheme:  IconThemeData(color: mainColor),
            backgroundColor: Colors.white,
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
                        child: TextFormField(
                          focusNode: controller.msgNode,
                          controller: controller.msgController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.message_rounded),
                            counterText: "",
                            hintText: AppLocalizations.of(context)!
                                .translate('writeReport'),
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
                        width: 300,
                        height: 50,
                        child: DropdownButton<Category>(
                          icon: Container(),
                          value: controller.selectCatogory,
                          items: controller.categories.map((Category? value) {
                            return DropdownMenuItem<Category>(
                              value: value,
                              child: Text("${value!.ctgName}"),
                            );
                          }).toList(),
                          onChanged: controller.selectingCategory,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: controller.levelLoading
                            ? const Loader( width: 300,
                          height: 50,)
                            : controller.levels.isEmpty
                                ? Container()
                                : DropdownButton<Category>(
                                    icon: Container(),
                                    value: controller.selectLevel,
                                    items: controller.levels.map((Category? value) {
                                      return DropdownMenuItem<Category>(
                                        value: value,
                                        child: Text("${value!.ctgName}"),
                                      );
                                    }).toList(),
                                    onChanged:controller.selectingLevels,
                                  ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: controller.studentsLoading
                            ? const Loader( width: 300,
                          height: 50,)
                            : controller.student.isEmpty
                                ? Container()
                                : DropdownButton<Student>(
                                    icon: Container(),
                                    value: controller.selectedStudent,
                                    items: controller.student.map((Student? value) {
                                      return DropdownMenuItem<Student>(
                                        value: value,
                                        child: Text("${value!.name}"),
                                      );
                                    }).toList(),
                                    onChanged:controller.selectingLevels,
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

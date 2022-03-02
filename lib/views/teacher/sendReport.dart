// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/models/teacher/student.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendReport extends StatefulWidget {
  const SendReport({Key? key}) : super(key: key);

  @override
  _SendReportState createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _msgController =  TextEditingController();
  final FocusNode _msgNode =  FocusNode();

  List<Category?> categories = [];
  List<Category?> levels = [];
  List<Student?> student = [];

  bool isLoading = false;
  bool categoryloading = true;
  bool levelLoading = false;
  bool studentsLoading = false;

  Category? selectCatogory = Category(ctgName: "اختار القسم");
  Category? selectLevel = Category(ctgName: "اختار المرحلة");
  Student? selectStudent = Student(name: "اختار طالب");

  Category? selectedCatogory;
  Category? selectedLevel;
  Student? selectedStudent;

  getCatgories() async {
    categories = await TeacherService().getCategories();
    categories.add(selectCatogory);
    categoryloading = false;
    setState(() {});
  }

  getLevels() async {
    levels = await TeacherService().getLevels(id: selectedCatogory!.id);
    levels.add(selectLevel);
    levelLoading = false;
    setState(() {});
  }

  getStudent() async {
    student = await TeacherService().getStudents(id: selectedLevel!.id);
    student.add(selectStudent);
    studentsLoading = false;
    setState(() {});
  }

  void unFocus() {
    _msgNode.unfocus();
    setState(() {});
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      if (selectedStudent != null) {
        isLoading = true;
        setState(() {});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? id = prefs.getString("id");
        TeacherService().sendReport(
            id: id, msg: _msgController.text, studentId: selectedStudent!.id);
        popPage(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCatgories();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme:  IconThemeData(color: mainColor),
          backgroundColor: Colors.white,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        focusNode: _msgNode,
                        controller: _msgController,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('reportError');
                          }
                          return null;
                        },
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
                        value: selectCatogory,
                        items: categories.map((Category? value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text("${value!.ctgName}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectCatogory = value;
                          selectedCatogory = value;
                          levelLoading = true;
                          getLevels();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: levelLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : levels.isEmpty
                              ? Container()
                              : DropdownButton<Category>(
                                  icon: Container(),
                                  value: selectLevel,
                                  items: levels.map((Category? value) {
                                    return DropdownMenuItem<Category>(
                                      value: value,
                                      child: Text("${value!.ctgName}"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectLevel = value;
                                    selectedLevel = value;
                                    studentsLoading = true;
                                    getStudent();
                                    setState(() {});
                                  },
                                ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: studentsLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : student.isEmpty
                              ? Container()
                              : DropdownButton<Student>(
                                  icon: Container(),
                                  value: selectedStudent,
                                  items: student.map((Student? value) {
                                    return DropdownMenuItem<Student>(
                                      value: value,
                                      child: Text("${value!.name}"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectStudent = value;
                                    selectedStudent = value;
                                    setState(() {});
                                  },
                                ),
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
    );
  }
}

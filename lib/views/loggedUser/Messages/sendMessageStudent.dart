// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/teachers.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/services/messagesService.dart';
import 'package:al_furqan_school/views/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMessageStudentScreen extends StatefulWidget {
  final int type;
   const SendMessageStudentScreen({Key? key, this.type = 1}) : super(key: key);
  @override
  _SendMessageStudentScreenState createState() =>
      _SendMessageStudentScreenState();
}

class _SendMessageStudentScreenState extends State<SendMessageStudentScreen> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _titleController =  TextEditingController();
  final TextEditingController _msgController =  TextEditingController();

  final FocusNode _titleNode =  FocusNode();
  final FocusNode _msgNode =  FocusNode();

  String? type = 'اختار المرسل له';
  String selected = "";
  List<Teachers?> teachers = [];
  Teachers? selectedTeacher;
  Teachers? selectTeacher = Teachers(name: "اختر مدرس");

  @override
  void initState() {
    super.initState();
    getTeachers();
  }

  getTeachers() async {
    isLoading = true;
    setState(() {});
    teachers = await MessagesService().getTeacher();
    teachers.add(selectTeacher);
    isLoading = false;
    setState(() {});
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("id");
      String? done = widget.type != 1
          ? await ParentService().sendMessage(
              teacherId: selectedTeacher == null ? "" : selectedTeacher!.id,
              title: _titleController.text,
              msg: _msgController.text,
              id: id,
              type: selected)
          : await MessagesService().sendMessage(
              teacherId: selectedTeacher == null ? "" : selectedTeacher!.id,
              title: _titleController.text,
              msg: _msgController.text,
              id: id,
              type: selected);
      isLoading = false;
      setState(() {});
      if (done == "true") {
        pushPageReplacement(context, const HomeScreen());
      } else {
        final snackBar = SnackBar(content: Text(done!));
        scaffoldKey.currentState!.showSnackBar(snackBar);
      }
      popPage(context);
    }
  }

  void unFocus() {
    _titleNode.unfocus();
    _msgNode.unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                  backgroundColor: white,
                ),
              )
            : Form(
                key: _formKey,
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
                        focusNode: _titleNode,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('titleError');
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
                        focusNode: _msgNode,
                        controller: _msgController,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('MessageError');
                          }
                          return null;
                        },
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
                        value: type,
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
                        onChanged: (value) {
                          type = value;
                          selected = type == 'مدرس' ? "teacher" : "admin";
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: selected == "admin"
                          ? Container()
                          : DropdownButton<Teachers>(
                              icon: Container(),
                              value: selectTeacher,
                              dropdownColor: white,
                              items: teachers.map((Teachers? value) {
                                return DropdownMenuItem<Teachers>(
                                  value: value,
                                  child: Text("${value!.name}",style: TextStyle(color: mainColor),),
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectTeacher = value;
                                selectedTeacher = value;
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

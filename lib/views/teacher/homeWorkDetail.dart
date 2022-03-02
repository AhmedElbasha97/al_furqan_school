// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/models/teacher/HomeWorkDetails.dart';
import 'package:al_furqan_school/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../globals/commonStyles.dart';

class HomeWorkDetailsScreen extends StatefulWidget {
  final String? id;
  const HomeWorkDetailsScreen({Key? key, this.id = ""}) : super(key: key);
  @override
  _HomeWorkDetailsScreenState createState() => _HomeWorkDetailsScreenState();
}

class _HomeWorkDetailsScreenState extends State<HomeWorkDetailsScreen> {
  bool isLoading = true;
  List<HomeWorkDetailsTeacherModel> homework = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    homework = await TeacherService()
        .getHomeworkDetails(id: id, homeworkId: widget.id);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: mainColor),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: homework.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${homework[index].title}"),
                      Text("${homework[index].date}"),
                      Text(homework[index].teacherName ?? ""),
                      Html(data: "${homework[index].homeworkDet}"),
                      homework[index].homeworkFile != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppBtn(
                                label: AppLocalizations.of(context)!
                                    .translate('download')??"",
                                onClick: () async {
                                  if (await canLaunch(
                                      "${homework[index].homeworkFile}")) {
                                    await launch(
                                        "${homework[index].homeworkFile}");
                                  } else {
                                    throw 'Could not launch ${homework[index].homeworkFile}';
                                  }
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

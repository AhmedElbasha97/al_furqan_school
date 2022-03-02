// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/subject.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:al_furqan_school/views/appData/subjectDetails.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  bool isLoading = true;
  List<Subjects> subjects = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    subjects = await AppInfoService().getSubjects();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: isLoading
            ?  Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                  backgroundColor: white,
                ),
              )
            : ListView.separated(
                itemCount: subjects.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pushPage(
                            context,
                            SubjectDetailsScreen(
                              id: subjects[index].id,
                            ));
                      },
                      child: ListTile(
                        title: Text("${subjects[index].miName}"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}

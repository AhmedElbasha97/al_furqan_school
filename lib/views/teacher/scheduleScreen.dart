// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/models/schedule.dart';
import 'package:al_furqan_school/services/teacherSchedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherSchedule extends StatefulWidget {
  const TeacherSchedule({Key? key}) : super(key: key);

  @override
  _TeacherScheduleState createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {
  bool isLoading = true;
  List<Schedule> schedule = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    schedule = await TeacherScheduleService().getSchedule(id: id);
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
          : ListView.separated(
              itemCount: schedule.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${schedule[index].day}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Text("${schedule[index].class1??""}"),
                      Text("${schedule[index].class2??""}"),
                      Text("${schedule[index].class3??""}"),
                      Text("${schedule[index].class4??""}"),
                      Text("${schedule[index].class5??""}"),
                      Text("${schedule[index].class6??""}"),
                      Text("${schedule[index].class7??""}"),
                      Text("${schedule[index].class8??""}"),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
    );
  }
}

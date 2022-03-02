// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/parents/reports.dart';
import 'package:al_furqan_school/services/ParentsService.dart';
import 'package:al_furqan_school/views/parents/ReportDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isLoading = true;
  List<Report> reports = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    reports = await ParentService().getReports(id: id);
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
              itemCount: reports.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      pushPage(
                          context,
                          ReportsDetailScreen(
                            id: reports[index].reportId,
                          ));
                    },
                    title: Text("${reports[index].teacher}"),
                    trailing: Text("${reports[index].date}",style: TextStyle(color: mainColor),),
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

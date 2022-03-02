// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/models/homeWork.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/views/loggedUser/HomeWorkDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/commonStyles.dart';

class HomeWorkScreen extends StatefulWidget {
  const HomeWorkScreen({Key? key}) : super(key: key);

  @override
  _HomeWorkScreenState createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  bool isLoading = true;
  List<HomeWork> homeworks = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    homeworks = await LoggedUser().getHomeWorks(id: id);
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
          ? Center(
              child: CircularProgressIndicator(
                color: mainColor,
                backgroundColor: white,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: homeworks.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pushPage(
                        context,
                        HomeWorkDetailsScreen(
                          id: homeworks[index].id??"",
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomeWorkCard(
                      title: homeworks[index].title ?? "",
                      date: homeworks[index].date ?? "",
                      teacherName: "${homeworks[index].teacherName ?? ""}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

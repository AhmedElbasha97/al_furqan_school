// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/models/AppInfo/aboutSchool.dart';
import 'package:al_furqan_school/services/appInfoService.dart';

class SchoolWord extends StatefulWidget {
  final bool isAbout;
  const SchoolWord({Key? key, this.isAbout = false}) : super(key: key);
  @override
  _SchoolWordState createState() => _SchoolWordState();
}

class _SchoolWordState extends State<SchoolWord> {
  late AboutSchool word;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    word = widget.isAbout
        ? await AppInfoService().getAboutSchool()
        : await AppInfoService().getSchoolWord();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
      body: loading
          ?  Center(child: CircularProgressIndicator(
        color: mainColor,
        backgroundColor: white,
      ))
          : ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${word.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(data: word.description),
                )
              ],
            ),
    );
  }
}
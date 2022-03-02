// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/homeWorkCard.dart';
import 'package:al_furqan_school/models/importantFiles.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesImportantScreen extends StatefulWidget {
  const FilesImportantScreen({Key? key}) : super(key: key);

  @override
  _FilesImportantScreenState createState() => _FilesImportantScreenState();
}

class _FilesImportantScreenState extends State<FilesImportantScreen> {
  bool isLoading = true;
  List<ImportantFile> files = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    files = await LoggedUser().getImportantFiles(id: id);
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
              itemCount: files.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch("${files[index].file}")) {
                        await launch("${files[index].file}");
                      } else {
                        throw 'Could not launch ${files[index].file}';
                      }
                    },
                    child: HomeWorkCard(
                      title: "${files[index].title}",
                      date: "${files[index].desc}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

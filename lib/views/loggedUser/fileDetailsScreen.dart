// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/models/FilesDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FileDetailsScreen extends StatefulWidget {
  final String? id;
  const FileDetailsScreen({Key? key, this.id = ""}) : super(key: key);
  @override
  _FileDetailsScreenState createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> {
  bool isLoading = true;
  List<FileDetails> files = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    files = await LoggedUser().getFilesDetails(id: id, fileID: widget.id ?? "");
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${files[index].title}"),
                      Text("${files[index].date}"),
                      Html(data: "${files[index].fileDet}"),
                      files[index].fileLink != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppBtn(
                                label: AppLocalizations.of(context)!
                                    .translate('download')??"",
                                onClick: () async {
                                  if (await canLaunch(
                                      "${files[index].fileLink}")) {
                                    await launch("${files[index].fileLink}");
                                  } else {
                                    throw 'Could not launch ${files[index].fileLink}';
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

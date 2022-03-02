// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/models/questionDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final String? id;
  const QuestionDetailsScreen({Key? key, this.id}) : super(key: key);
  @override
  _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  bool isLoading = true;
  List<QuestionDetails> qustions = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    qustions =
        await LoggedUser().getQuestionsDetails(id: id, qId: widget.id ?? "");
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
          : ListView.builder(
              itemCount: qustions.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${qustions[index].title}",                style: TextStyle(color: mainColor),
                      ),
                      Text("${qustions[index].date}"),
                      Html(data: "${qustions[index].fileDet}"),
                      qustions[index].fileLink != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppBtn(
                                label: AppLocalizations.of(context)!
                                    .translate('download')??"",
                                onClick: () async {
                                  if (await canLaunch(
                                      "${qustions[index].fileLink}")) {
                                    await launch(
                                        "${qustions[index].fileLink}");
                                  } else {
                                    throw 'Could not launch ${qustions[index].fileLink}';
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

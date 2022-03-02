// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/models/AppInfo/subjectDetails.dart';
import 'package:al_furqan_school/services/appInfoService.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final String? id;
  const SubjectDetailsScreen({Key? key, this.id}) : super(key: key);
  @override
  _SubjectDetailsScreenState createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  bool isLoading = true;
  List<SubjectDetails> details = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    details = await AppInfoService().getSubjectDetails(id: widget.id);
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
              itemCount: details.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${details[index].image}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${details[index].title}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Html(data: "${details[index].description}"),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

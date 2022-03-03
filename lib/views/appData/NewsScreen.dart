// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/AppInfo/News.dart';
import 'package:al_furqan_school/services/appInfoService.dart';

import 'NewsDetailsScreen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
    bool isLoading = true;
  List<News> news = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    news = await AppInfoService().getNews();
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
                itemCount: news.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pushPage(
                            context,
                            NewsDetailsScreen(
                              id: news[index].id,
                            ));
                      },
                      child: ListTile(
                        title: Text("${news[index].title}"),
                        subtitle: Text("${news[index].brief}"),
                        trailing:  Icon(Icons.arrow_forward_ios,color: mainColor,),
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
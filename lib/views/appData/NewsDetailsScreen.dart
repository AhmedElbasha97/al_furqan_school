// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/models/AppInfo/newsDetails.dart';
import 'package:al_furqan_school/services/appInfoService.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String? id;
  const NewsDetailsScreen({Key? key, this.id}) : super(key: key);
  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isLoading = true;
  List<NewsDetails> news = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    news = await AppInfoService().getNewsDetails(id: widget.id);
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
              padding: const EdgeInsets.all(10),
              itemCount: news.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${news[index].title}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        options:
                            CarouselOptions(height: 150.0, autoPlay: true),
                        items: news[index].images!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("$i"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Html(data: "${news[index].description}"),
                      const SizedBox(
                        height: 15,
                      ),
                      news[index].video != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppBtn(
                                label: AppLocalizations.of(context)!
                                    .translate('viewVideo')??"",
                                onClick: () async {
                                  if (await canLaunch(
                                      "${news[index].video}")) {
                                    await launch("${news[index].video}");
                                  } else {
                                    throw 'Could not launch ${news[index].video}';
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

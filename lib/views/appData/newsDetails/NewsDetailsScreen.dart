// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/appData/newsDetails/controller/new_details_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:get/get.dart';

class NewsDetailsScreen extends StatelessWidget {

  const NewsDetailsScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  NewsDetailsController(context),
      builder: (NewsDetailsController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ? const Loader()
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.news.title}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        controller.noPhotos?
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                                child: Image.asset("assets/images/no_image.png"))
                            :
                        CarouselSlider(
                          options:
                              CarouselOptions(height: 150.0, autoPlay: controller.photos.length==1?false:true),
                          items: controller.photos.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(i),
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
                        Html(data: "${controller.news.description}"),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.news.video != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)!
                                      .translate('viewVideo')??"",
                                  onClick: () async {
                                    controller.launchURL(context);
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

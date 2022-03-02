// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/DrawerWidget.dart';
import 'package:al_furqan_school/globals/widgets/HomeCard.dart';
import 'package:al_furqan_school/models/AppInfo/photoAlbum.dart';
import 'package:al_furqan_school/models/AppInfo/sliderPhotos.dart';
import 'package:al_furqan_school/models/AppInfo/videos.dart';
import 'package:al_furqan_school/services/albums.dart';
import 'package:al_furqan_school/services/appInfoService.dart';

import 'appData/schoolWord.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SliderData> sliderData = [];
  List<PhotoAlbum> list = [];
  List<Videos> list2 = [];

  bool loading = true;
  @override
  void initState() {
    super.initState();
    getHomeData();
  }

  getHomeData() async {
    sliderData = await AppInfoService().getSliderPhotos();
    await getAlbumsData();
    loading = false;
    setState(() {});
  }

  getAlbumsData() async {
    list = await AlbumsService().getphotoAlbums();
    list2 = await AlbumsService().getVideoAlbums();
  }

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      backgroundColor: white,
      body: loading
          ?  Center(
              child: CircularProgressIndicator(
                color: mainColor,
                backgroundColor: white,
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 150.0, autoPlay: true),
                  items: sliderData.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${i.img}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('aboutTheSchool')!,
                    style: appText.copyWith(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      HomeCard(
                        onTap: () {
                          pushPage(context, const SchoolWord());
                        },
                        title:
                            "${AppLocalizations.of(context)!.translate('schoolWord')}",
                        imageLink: "assets/images/school.png",
                      ),

                      HomeCard(
                        onTap: () {
                          pushPage(
                              context,
                              const SchoolWord(
                                isAbout: true,
                              ));
                        },
                        title:
                            "${AppLocalizations.of(context)!.translate('schoolVision')}",
                        imageLink: "assets/images/vision.png",
                      ),
                    ],
                  ),
                ),
// ====================================================================
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('news')!,
                    style: appText.copyWith(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      HomeCard(
                        width: 250,
                        onTap: () {
                          pushPage(context, const SchoolWord());
                        },
                        title:
                            "${AppLocalizations.of(context)!.translate('activity')}",
                        imageLink: "assets/images/activities.png",
                      ),
                      HomeCard(
                        width: 250,
                        onTap: () {
                          pushPage(context, const SchoolWord());
                        },
                        title:
                            "${AppLocalizations.of(context)!.translate('newNews')}",
                        imageLink: "assets/images/newNews.png",
                      ),
                    ],
                  ),
                ),
// ====================================================================
// ====================================================================
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('PhotosAlbum')!,
                    style: appText.copyWith(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 150.0, autoPlay: true),
                  items: list.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${i.img}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                        );
                      },
                    );
                  }).toList(),
                ),
// ====================================================================
// ====================================================================
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('videosAlbum')!,
                    style: appText.copyWith(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 150.0, autoPlay: true),
                  items: list2.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${i.img}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                        );
                      },
                    );
                  }).toList(),
                ),
// ====================================================================
              ],
            ),
    );
  }
}

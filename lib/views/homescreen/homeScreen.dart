// ignore_for_file: file_names
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/albums/AlbumsScreen.dart';
import 'package:al_furqan_school/views/appData/newsScreen/NewsScreen.dart';
import 'package:al_furqan_school/views/homescreen/controller/home_screen_cotroller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/other/photoAlbums/photosAlbum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/DrawerWidget.dart';
import 'package:al_furqan_school/globals/widgets/HomeCard.dart';
import 'package:get/get.dart';
import '../../globals/widgets/news_card.dart';
import '../appData/schoolword/schoolWord.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init:  HomeScreenController(context),
      builder: (HomeScreenController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
          title: Image.asset(
            "assets/images/logo 2020 new.png",
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height*0.07,
            width: MediaQuery.of(context).size.width*0.1,
          ),
          centerTitle: true,
        ),
        drawer:  const AppDrawer(),
        onDrawerChanged:(val){
          if(val){

          }else{
            print("hiiiii");
            controller.getHomeData();
            controller.getAlbumsData();
            controller.getVideoData();
            controller.getData();
          }
        },
        backgroundColor: white,
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),        body:  ListView(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  controller.slideShowLoading?Loader(width: MediaQuery.of(context).size.width,height: 150.0):CarouselSlider(
                    options: CarouselOptions(height: 150.0, autoPlay: true),
                    items: controller.sliderData.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return  CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "${i.img}",
                            imageBuilder: ((context, image){
                              return  Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: image,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(15))

                                  )
                              );
                            }),
                            placeholder: (context, image){
                              return  Padding(
                                padding:  const EdgeInsets.all(5),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Loader(width: MediaQuery.of(context).size.width,height: 150.0)),
                              );
                            },
                            errorWidget: (context, url, error){
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/no_data_slideShow.png"),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))

                                  )
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: MediaQuery.of(context).size.width*0.7,

                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations.of(context)!.translate('aboutTheSchool')!,
                          style: appText.copyWith(
                             color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
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
                           Get.to(()=>const SchoolWord(),arguments: [false]);
                          },
                          title:
                              "${AppLocalizations.of(context)!.translate('schoolWord')}",
                          imageLink: "assets/images/school.png",
                        ),

                        HomeCard(
                          onTap: () {
                            Get.to(()=>const SchoolWord(),arguments: [true]);
                          },
                          title:
                              "${AppLocalizations.of(context)!.translate('schoolVision')}",
                          imageLink: "assets/images/logo 2020 new.png",
                        ),
                      ],
                    ),
                  ),
// ====================================================================

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>const NewsScreen());
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "الأخبار",
                            style: appText.copyWith(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller.newsShowLoading?Loader(width: MediaQuery.of(context).size.width,height: 150.0):controller.news!.isEmpty?Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Center(
                          child:  Text("ليس هناك إخبار متوفره الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                      )):SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.news?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ContainerCardWidget(
                          title: controller.news![index].title,
                          subTtitle: controller.news![index].brief,
                        );
                      },

                    ),
                  ),
// ====================================================================
// ====================================================================
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        Get.to(()=>const AlbumsScreen(),arguments: [true]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.translate('PhotosAlbum')!,
                            style: appText.copyWith(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  controller.list.isEmpty?Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Center(
                          child:  Text("ليس هناك صور متاحه الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                      )) :controller.galleryShowLoading?Loader(width: MediaQuery.of(context).size.width,height: 150.0):CarouselSlider(
                    options: CarouselOptions(height: 150.0, autoPlay: true),
                    items: controller.list.map((i) {

                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: (){Get.to(()=>const PhotosAlbum(),arguments: [i.id,i.title]);
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                                imageUrl: "${i.img}",
                              imageBuilder: ((context, image){
                                 return  Container(
                                     width: MediaQuery.of(context).size.width,
                                     margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                     decoration: BoxDecoration(
                                     image: DecorationImage(
                                     image: image,
                                fit: BoxFit.cover,
                                ),
                                         borderRadius:
                                         const BorderRadius.all(Radius.circular(15))

                                     )
                                 );
                              }),
                              placeholder: (context, image){
                                  return  Loader(width: MediaQuery.of(context).size.width,height: 150.0);
                              },
                              errorWidget: (context, url, error){
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/no_data_slideShow.png"),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15))

                                      )
                                  );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
// ====================================================================
// ====================================================================
                    const SizedBox(
                      height: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        Get.to(()=>const AlbumsScreen(),arguments: [true]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            AppLocalizations.of(context)!.translate('videosAlbum')!,
                            style: appText.copyWith(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  controller.list2.isEmpty?Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Center(
                      child:  Text("ليس هناك فيديوهات متاحه الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                    ),
                  ):controller.videosShowLoading?Loader(width: MediaQuery.of(context).size.width,height: 150.0):CarouselSlider(
                    options: CarouselOptions(height: 150.0, autoPlay: true),
                    items: controller.list2.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: ()async{
                              controller.launchURL(context,i.link);
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${i.img}",
                              imageBuilder: ((context, image){
                                return  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: image,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(15))

                                    )
                                );
                              }),
                              placeholder: (context, image){
                                return Loader(width: MediaQuery.of(context).size.width,height: 150.0);
                              },
                              errorWidget: (context, url, error){
                                return Container(
                                    width: MediaQuery.of(context).size.width,

                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/no_data_slideShow.png",),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))

                                    )
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
// ====================================================================
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
      ),
    );
  }
}

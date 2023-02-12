import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/expandable_text.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/the%20_department/the_department_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'contreller/start_screen_controller.dart';
import 'more_informaton_screen.dart';
class ChooseStateScreen extends StatelessWidget {
  const ChooseStateScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: StartScreen(context),
      builder: (StartScreen controller) => Scaffold(
         bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading?
            const Loader():SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      controller.imageData?.isEmpty??true? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.2,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/no_data_slideShow.png",),
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))

                          )
                      ) : CarouselSlider.builder(
                        carouselController: controller.carosuelController,
                        itemCount: controller.imageData?.length,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return CachedNetworkImage(imageUrl: controller.imageData?[index].img??"",
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height*0.45,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => Loader(height: MediaQuery.of(context).size.height*0.45,
                              width: MediaQuery.of(context).size.width,),

                            errorWidget: (context, url, error) =>SizedBox(
                              height: MediaQuery.of(context).size.height*0.45,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset("assets/images/logo 2020 new.png"),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: controller.imageData?.length == 1?false:true,
                          enlargeCenterPage: false,
                          scrollPhysics: controller.imageData?.length == 1?const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
                          height: MediaQuery.of(context).size.height*0.45,
                          viewportFraction: 1.0,

                          onPageChanged: controller.carouseChangeIndex,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor,width: 2),
                              borderRadius: BorderRadius.circular(10)

                          ),
                          height: MediaQuery.of(context).size.height*0.17,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,//.horizontal
                              child:  Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "من نحن",
                                          style: appText.copyWith(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),

                                      ),
                                    ),
                                  ),
                                  ExpandableText(

                                    controller.about?.brief??"" , trimLines: 3, readMoreButtonTitle: 'اظهر المزيد',readLessButtonTitle: 'اظهر اقل',readMoreStyle: TextStyle(
                                    fontSize: 16.0, color: teal, fontWeight: FontWeight.bold
                                  ),textStyle: TextStyle(
                                    fontSize: 16.0, color: mainColor,
                                  ), openingPage: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const MoreInformationScreen(),
                                    ));
                                  },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                              border: Border.all(color: mainColor,width: 2),
                              borderRadius: BorderRadius.circular(10)

                          ),
                          width: MediaQuery.of(context).size.width*0.95,
                          child: Padding(

                            padding: const EdgeInsets.all(10),
                            child: ListTile(

                              onTap: () {

                              },
                              tileColor: mainColor,
                              title:  ExpandableNotifier(

                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(
                                          theme:  ExpandableThemeData(
                                            iconColor: white,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment.center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "المدارس",maxLines: null,
                                                softWrap: true,
                                                style: TextStyle(fontSize: 15, color: white),
                                              ),

                                            ],
                                          ),
                                          expanded:Column(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  controller.chooseSchool(0);
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                    color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "مدرسة الفرقان الابتدائية",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  controller.chooseSchool(1);
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "مدرسة الفرقان الإعدادية",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                controller.chooseSchool(2);
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,

                                                      children: [
                                                        Text(
                                                          "مدرسة الفرقان الثانوية",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          collapsed: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("المرحلة الدراسية",style: TextStyle(fontSize: 15, color: white),),
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, bottom: 10),
                                              child: Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,

                                                theme: const ExpandableThemeData(
                                                    crossFadePoint: 0),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),),
                          ),),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              border: Border.all(color: mainColor,width: 2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: MediaQuery.of(context).size.width*0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(

                              onTap: () {

                              },
                              tileColor: mainColor,
                              title:  ExpandableNotifier(

                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(

                                          theme:  ExpandableThemeData(
                                            iconColor: white,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment.center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "المكاتب والأقسام",maxLines: null,
                                                softWrap: true,
                                                style: TextStyle(fontSize: 15, color: white),
                                              ),

                                            ],
                                          ),
                                          expanded:Column(
                                            children:
                                             controller.departmentData.map((e) =>  Column(
                                               children: [
                                                 InkWell(
                                                   onTap: (){
                                                     Get.to(() =>const DepartmentDetailScreen(),
                                                       arguments: [e.id],
                                                     );
                                                   },
                                                   child: Container(

                                                     width: MediaQuery.of(context).size.width*0.9,
                                                     decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(15),
                                                         color: white
                                                     ),
                                                     child:  Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         crossAxisAlignment: CrossAxisAlignment.center,
                                                         children: [
                                                           SizedBox(
                                                             width: Get.width*0.6,
                                                             child:  Text(
                                                               e.title??"",
                                                               style: TextStyle(
                                                                   color: mainColor
                                                               ),
                                                               maxLines: null,
                                                             ),
                                                           ),

                                                           Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                                 const SizedBox(
                                                   height: 10,
                                                 )
                                               ],
                                             ),
                                               ).toList(),


                                          ),

                                          collapsed: const Align(
                                            alignment: Alignment.centerRight,
                                           ),

                                          builder: (_, collapsed, expanded) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, bottom: 10),
                                              child: Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,

                                                theme: const ExpandableThemeData(
                                                    crossFadePoint: 0),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),),
                          ),),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/the%20_department/controller/the_department_controller.dart';
import 'package:al_furqan_school/views/the%20_department/photo_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
class DepartmentDetailScreen extends StatefulWidget {
  const DepartmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<DepartmentDetailScreen> createState() => _DepartmentDetailScreenState();
}

class _DepartmentDetailScreenState extends State<DepartmentDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  ExpandableController contExpansion = ExpandableController();
  ExpandableController controllerExpantion = ExpandableController();
  DraggableScrollableController controllerDragableSheet = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TheDepartmentController(context),
      builder: (TheDepartmentController controller) =>  Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:  Text(controller.department?.title??"",
            style: TextStyle(
              color: white, fontWeight: FontWeight.bold, fontSize: 14),),
        centerTitle: true,
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading?const Loader()
              :controller.hasNoData? SizedBox(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no-connection.png",height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width*0.4,),
              Text("ليس هناك معلومات متوفره عن هذا القسم الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30,),textAlign: TextAlign.center,)
            ],
          ),
        )
         :Stack(
           children: [

             Positioned(
               top: 0,
               left: 0,
               right: 0,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                         "الوصف:",
                          style: appText.copyWith(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),

                      ),
                    ),
                  ),
                  Wrap(
                    children:  [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
                        child: SizedBox(
                          height:Get.height*0.15,
                          child:  SingleChildScrollView(
                            scrollDirection: Axis.vertical,//.horizontal

                            child: Text(controller.department!.brief??"",
                              style: appText.copyWith(
                                  color: mainColor,

                                  fontSize: 16),
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
        ),
             ),
             DraggableScrollableSheet(
                  controller: controllerDragableSheet,
                 initialChildSize: 0.75,
                 minChildSize: 0.75,
                 maxChildSize: 1,
                 builder: (context,  ScrollController scrollController) {
                   return Padding(
                     padding:  EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
                     child: Container(
                       decoration: BoxDecoration(
                           color: white,
                           border: Border.all(color: mainColor,width: 2),
                           borderRadius: BorderRadius.circular(10)
                       ),
                       height: MediaQuery.of(context).size.height*0.6,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: SingleChildScrollView(
                           controller: scrollController,
                           child: Column(
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                   color: mainColor,
                                   borderRadius: BorderRadius.circular(5.0),
                                 ),
                                 width: MediaQuery.of(context).size.width,
                                 child: Padding(
                                   padding: const EdgeInsets.all(5.0),
                                   child: Text(
                                     "الفعليات :",
                                     style: appText.copyWith(
                                         color: white,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 16),
                                   ),

                                 ),
                               ),
                             const SizedBox(height: 10,),
                             Column(
                               children:   controller.department?.activity?.map((e) => Column(
                                 children: [
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

                                         tileColor: mainColor,
                                         title:  ExpandableNotifier(
                                           controller: contExpansion,


                                           child: Padding(
                                             padding: const EdgeInsets.all(10),
                                             child: Column(
                                               children: <Widget>[
                                                 ExpandablePanel(

                                                   theme:  ExpandableThemeData(
                                                     iconColor: white,
                                                     headerAlignment:
                                                     ExpandablePanelHeaderAlignment.center,
                                                     tapBodyToCollapse: true,
                                                   ),
                                                   header: Wrap(
                                                     children: [
                                                       SizedBox(
                                                         width: Get.width*0.7,
                                                         child: Text(
                                                          e.title??"",
                                                           softWrap: true,
                                                           style: TextStyle(fontSize: 15, color: white),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                   expanded:Column(
                                                       children:[
                                                         Padding(
                                                           padding: const EdgeInsets.all(8.0),
                                                           child: e.img!=""?Image.network( e.img??"",height: MediaQuery.of(context).size.height*0.2,width: MediaQuery.of(context).size.width*0.75,):Container(),
                                                         ),
                                                         e.imgs?[0]==""?Container():CarouselSlider(
                                                           options: CarouselOptions(
                                                             autoPlay: true,
                                                             // enlargeCenterPage: true,
                                                             //scrollDirection: Axis.vertical,
                                                             onPageChanged: (index, reason) {
                                                              controller.updateCurrentIndex(index);
                                                             },
                                                           ),
                                                           items: e.
                                                               imgs?.map(
                                                                 (item) => InkWell(
                                                                   onTap: (){
                                                                     Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                                       return  PhotoDetailedScreen(link: item,index: "${controller.currentIndex}",);
                                                                     }));
                                                                   },
                                                                   child: Padding(
                                                               padding: const EdgeInsets.all(8.0),
                                                               child: Card(
                                                                   margin: const EdgeInsets.only(
                                                                     top: 10.0,
                                                                     bottom: 10.0,
                                                                   ),
                                                                   elevation: 6.0,
                                                                   shadowColor: Colors.redAccent,
                                                                   shape: RoundedRectangleBorder(
                                                                     borderRadius: BorderRadius.circular(30.0),
                                                                   ),
                                                                   child: ClipRRect(
                                                                     borderRadius: const BorderRadius.all(
                                                                       Radius.circular(20.0),
                                                                     ),
                                                                     child: Stack(
                                                                       children: <Widget>[
                                                                         Hero(
                                                                           tag:"imageHero${controller.currentIndex}",
                                                                           child: Image.network(
                                                                             item,
                                                                             fit: BoxFit.cover,
                                                                             width: double.infinity,
                                                                           ),
                                                                         ),

                                                                       ],
                                                                     ),
                                                                   ),
                                                               ),
                                                             ),
                                                                 ),
                                                           )
                                                               .toList(),
                                                         ),
                                                 e.imgs?[0]==""?Container():Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: e.imgs?.map((urlOfItem) {
                                                   int index = e.imgs?.indexOf(urlOfItem)??0;
                                                   return Container(
                                                     width: 10.0,
                                                     height: 10.0,
                                                     margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                                     decoration: BoxDecoration(
                                                       shape: BoxShape.circle,
                                                       color: controller.currentIndex == index
                                                           ? const Color.fromRGBO(0, 0, 0, 0.8)
                                                           : const Color.fromRGBO(0, 0, 0, 0.3),
                                                     ),
                                                   );
                                                 }).toList()??[],
                                               ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(8.0),
                                                           child:Html (
                                                             data:e.desc??"",
                                                             style: {
                                                               "body": Style(
                                                                 fontSize: const FontSize(15.0),
                                                                 color: white
                                                               ),
                                                             },
                                                           ),),

                                                       ]
                                                   ),

                                                   collapsed: Align(
                                                     alignment: Alignment.centerRight,
                                                     child: Text("للمزيد من المعلومات",style: TextStyle(fontSize: 15, color: white),),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),),
                                     ),),
                                   const SizedBox(height: 15,)
                                 ],
                               )).toList()??[const SizedBox()],
                             )

                             ],
                           ),
                         ),
                       ),
                     ),
                   );}
             )
           ],
         ),
      ),
    );
  }
}
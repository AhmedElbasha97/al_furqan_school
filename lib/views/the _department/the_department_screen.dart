import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/the%20_department/controller/the_department_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
class DepartmentDetailScreen extends StatelessWidget {
  const DepartmentDetailScreen({Key? key}) : super(key: key);


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
Padding(padding: const EdgeInsets.all(10),
child: Text(controller.department!.brief??"",
  style: appText.copyWith(
      color: mainColor,

      fontSize: 16),

),),

                ],
        ),
             ),
             DraggableScrollableSheet(
               
                 initialChildSize: 0.75,
                 minChildSize: 0.75,
                 maxChildSize: 1,
                 builder: (context, scrollController) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       decoration: BoxDecoration(
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
                               children:   controller.department!.activity!.map((e) => Column(
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
                                                          e.title??"",maxLines: null,
                                                           softWrap: true,
                                                           style: TextStyle(fontSize: 15, color: white),
                                                         ),

                                                       ],
                                                     ),
                                                     expanded:Column(
                                                         children:[
                                                           Padding(
                                                             padding: const EdgeInsets.all(8.0),
                                                             child: Image.network( e.img??"",height: MediaQuery.of(context).size.height*0.2,width: MediaQuery.of(context).size.width*0.75,),
                                                           ),
                                                           Padding(
                                                             padding: const EdgeInsets.all(8.0),
                                                             child:Html (
                                                               data:e.desc??"",
                                                             ),),
                                                         ]
                                                     ),

                                                     collapsed: Align(
                                                       alignment: Alignment.centerRight,
                                                       child: Text("للمزيد من المعلومات",style: TextStyle(fontSize: 15, color: white),),
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),),
                                     ),),
                                   const SizedBox(height: 15,)
                                 ],
                               )).toList(),
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
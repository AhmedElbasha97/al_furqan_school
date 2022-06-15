// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/messages/massagescreen/controller/massage_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/views/teacher/messages/messageDetails/messageDetails.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MessageController(context),
      builder: (MessageController controller) =>  Scaffold(
        appBar:AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ? const Loader()
            : controller.hasNoData?RefreshIndicator(
            onRefresh: () async {controller.getData();},
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_messages.png"),
                    Text("لم يتم ارسال اي رساله حتى الان",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            )):RefreshIndicator(
          onRefresh: () async {controller.getData();},
          child:ListView.separated(
                  itemCount: controller.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                          ()=>
                          const MessageDetailsScreen(),
                          arguments: [controller.messages[index].msgId]);
                          },
                        title: Text("${controller.messages[index].title}"),
                        trailing: Text("${controller.messages[index].date}"),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
            ),
      ),
    );
  }
}

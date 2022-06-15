// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/teacher/messages/messageDetails/controller/message_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class MessageDetailsScreen extends StatelessWidget {

  const MessageDetailsScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MessageDetailsController(context),
      builder: (MessageDetailsController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ?const Loader():
        controller.msg.isEmpty?
        SizedBox(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no_messages.png"),
              Text("ليس هناك معلومات عن هذه الرساله",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
            ],
          ),
        ): ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.msg.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.msg[index].title}"),
                        Text("${controller.msg[index].date}"),
                        Text(controller.msg[index].to ?? ""),
                        controller.hasNoData?  Container():Html(data: "${controller.msg[index].text}"),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

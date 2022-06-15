// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/Messages/sentMessageDetails/controller/sent_message_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class SentMessageDetails extends StatelessWidget {

  const SentMessageDetails({Key? key, }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  SentMessageDetailsController(context),
      builder: (SentMessageDetailsController controller) => Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),        body: controller.isLoading
            ?  const Loader()
            : ListView.builder(
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
                        Text(controller.msg[index].from ?? ""),
                        controller.hasNoData? Container():Html(data: "${controller.msg[index].text}"),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// ignore_for_file: file_names

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
        appBar: AppBar(),
        body: controller.isLoading
            ? const Loader()
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

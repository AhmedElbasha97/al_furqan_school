// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/appData/schoolword/controller/school_word_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class SchoolWord extends StatelessWidget {

  const SchoolWord({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  SchoolWordController(context),
      builder: (SchoolWordController controller) =>   Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.loading
            ?  const Loader()
            : ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${controller.word.image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(data: controller.word.description),
                  )
                ],
              ),
      ),
    );
  }
}

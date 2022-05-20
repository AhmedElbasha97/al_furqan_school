// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/loggedUser/filesDetails/controller/file_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:get/get.dart';

class FileDetailsScreen extends StatelessWidget {
  const FileDetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  FilesDetailsScreen(context),
      builder: (FilesDetailsScreen controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        body: controller.isLoading
            ? const Loader()
            : ListView.builder(
                itemCount: controller.files.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.files[index].title}"),
                        Text("${controller.files[index].date}"),
                        controller.hasFileData(index)?
                        Html(data: "${controller.files[index].fileDet}"):Container(),
                        controller.hasFileLink(index)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)!
                                      .translate('download')??"",
                                  onClick: () async {
                                  controller.launchURL(context, index);
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

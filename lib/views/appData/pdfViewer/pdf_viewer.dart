import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/appData/pdfViewer/controller/pdf_viewer_controller.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({Key? key}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:  PdfViewerController(context),
    builder: (PdfViewerController controller) =>
    Scaffold(
    appBar: AppBar(
    iconTheme:  IconThemeData(color: white),
    backgroundColor: mainColor,
    ),
    bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
      body: controller.isLoading ?
      const Loader()
        :controller.hasNoData?
      SizedBox(
    height: MediaQuery.of(context).size.height ,
    width: MediaQuery.of(context).size.width,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset("assets/images/no_books.png"),
    Text("ليس هناك اى معلومات متاحه الان عن هذا المنهج",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)
    ],
    ),
    ):PDFViewer(
        document: controller.document,
        zoomSteps: 1,
        pickerButtonColor:mainColor,
        scrollDirection: Axis.vertical,
         navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(

                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage(page: 0);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page! - 2);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages! - 1);
                          },
                        ),
                      ],
                    );
                  },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,80),
        child: FloatingActionButton(
          onPressed: () async {
             print(await controller.saveFile());
             },
          backgroundColor: mainColor,
          child: const Icon(Icons.download_for_offline_outlined),
        ),
      ),
    ),
    );
  }
}

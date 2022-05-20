import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'contreller/start_screen_controller.dart';
class MoreInformationScreen extends StatelessWidget {
  const MoreInformationScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StartScreen(context),
      builder: (StartScreen controller) =>  Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme:  IconThemeData(color: white  ),
          backgroundColor: mainColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo 2020 new.png",
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.5,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: mainColor,width: 2),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,//.horizontal
                      child: Column(
                        children: [
                          controller.about?.image!=""?Image.network(controller.about?.image??""):const SizedBox(),
                          Html(data: controller.about?.description??""),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

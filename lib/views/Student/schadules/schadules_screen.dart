import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/views/Student/schadules/controller/schadules_controller.dart';
import 'package:al_furqan_school/views/Student/schadules/detailed_screen.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({Key? key}) : super(key: key);

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  SchedulesController(context),
      builder: (SchedulesController controller) =>  Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(color:white ),
          backgroundColor:mainColor ,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body:ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child:  DropdownButton<Category>(
                icon: Container(),
                value: controller.selectCategory,
                items: controller.categories.map((Category? value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text("${value!.ctgName}"),
                  );
                }).toList(),
                onChanged: controller.selectingCategory,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: controller.levelLoading
                  ? const Loader( width: 300,
                height: 50,)
                  : controller.levels.isEmpty
                  ? Container()
                  : DropdownButton<Category>(
                icon: Container(),
                value: controller.selectLevel,
                items: controller.levels.map((Category? value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text("${value!.ctgName}"),
                  );
                }).toList(),
                onChanged:controller.selectingLevels,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: controller.classLoading
                  ? const Loader( width: 300,
                height: 50,)
                  : controller.Class.isEmpty
                  ? Container()
                  : DropdownButton<Category>(
                icon: Container(),
                value: controller.selectClass,
                items: controller.Class.map((Category? value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text("${value!.ctgName}"),
                  );
                }).toList(),
                onChanged:controller.selectingClass,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            controller.imageLoading?Container():GestureDetector(
              child: Hero(
                  tag: 'imageHero',
                  child: CachedNetworkImage(
                    imageUrl:  controller.photoLink.img??"",
                    imageBuilder: ((context, image){
                      return  Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.3,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: image,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(15))

                          )
                      );
                    }),
                    placeholder:  (context, image){
                      return  Padding(
                        padding:  const EdgeInsets.all(5),
                        child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))
                            ),
                            child: Loader(width: MediaQuery.of(context).size.width,height: 150.0)),
                      );
                    },
                    errorWidget:(context, url, error){
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/no_data_slideShow.png"),
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))

                          )
                      );
                    },
                  )
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return  DetailedScreen(link: controller.photoLink.img,);
                }));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            controller.imageLoading?Container():Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () {
                    controller.downloadImage();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10))),
                    alignment: Alignment.center,
                    child: const Text(
                     "حمل الجدول",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

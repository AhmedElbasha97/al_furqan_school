// ignore_for_file: avoid_print

import 'package:al_furqan_school/views/Student/schadules/controller/schadules_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DetailedScreen extends StatefulWidget {
  final String? link;
  const DetailedScreen({Key? key,  this.link=""}) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  SchedulesController(context),
      builder: (SchedulesController controller) => Stack(
        children: [
          Center(
            child: Hero(
              tag: 'imageHero',
              child: PinchZoom(
                resetDuration: const Duration(milliseconds: 100),
                maxScale: 3.5,
                onZoomStart: (){print('Start zooming');},
                onZoomEnd: (){print('Stop zooming');},
                child: CachedNetworkImage(
                  imageUrl:  widget.link??"",
                  imageBuilder: ((context, image){
                    return  Container(
                        width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
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
                    return  const CircularProgressIndicator();
                  },
                  errorWidget: (context, url, error){
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
                ),
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.clear_outlined,
                  color: Colors.black,
                  size: 50,
                ),
              )),
        ],
      ),
    );
  }
}

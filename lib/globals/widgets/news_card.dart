import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ContainerCardWidget extends StatelessWidget {
  final String? title;
  final String? bg;
  final String? subTtitle;
  final buttonNavigation;

  const ContainerCardWidget(
      { Key? key, this.title, this.bg, this.subTtitle, this.buttonNavigation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.22,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                  elevation: 10,
                  color: white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                            image(),
                            imageBuilder: (context, imageProvider) => Container(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Image.asset('assets/Blogs.jpg',
                                  height: MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/Blogs.jpg',fit: BoxFit.fitWidth,
                                  height: MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width,),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height:   MediaQuery.of(context).size.height* 0.08 ,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      white.withOpacity(1),
                                     white.withOpacity(0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ))),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, bottom: 5,right: 10),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    child: Text(title!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: mainColor,
                                            fontWeight: FontWeight.bold)),
                                  )),

                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 16, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(subTtitle!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.4),
                                    fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          )),
    );
  }


  image() {
    if(bg == null){
      return "https://img.freepik.com/free-vector/live-breaking-news-template-style_23-2148509656.jpg?t=st=1652409477~exp=1652410077~hmac=ae0233085325a8a90f9074fa9c7769d417e7193eacc90bb05859c8446ae2793a&w=996";
    }else{
      return bg;
    }
  }
}
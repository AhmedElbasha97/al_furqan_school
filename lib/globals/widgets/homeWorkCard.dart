// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/UICard.dart';

class HomeWorkCard extends StatefulWidget {
  final String date;
  final String teacherName;
  final String title;
  const HomeWorkCard({Key? key, this.date = "", this.title = "", this.teacherName = ""}) : super(key: key);
  @override
  _HomeWorkCardState createState() => _HomeWorkCardState();
}

class _HomeWorkCardState extends State<HomeWorkCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UICard(
          cardContent: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,textAlign: TextAlign.center,),
                Text(widget.date,style: TextStyle(color: mainColor),),
                Text(widget.teacherName)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

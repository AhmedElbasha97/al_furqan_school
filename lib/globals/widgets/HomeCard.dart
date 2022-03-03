// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/widgets/UICard.dart';

class HomeCard extends StatefulWidget {
  final Function? onTap;
  final String? title;
  final String? imageLink;
  final double width;
  const HomeCard({Key? key, this.imageLink, this.onTap, this.title, this.width = 130}) : super(key: key);
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: widget.width,
        height: 100,
        child: InkWell(
          onTap: widget.onTap as void Function()?,
          child: UICard(
            cardContent: SizedBox(
              height: 80,
              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset("${widget.imageLink}"),
                  ),
                  Text("${widget.title}")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

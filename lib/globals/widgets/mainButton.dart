// ignore_for_file: file_names, sort_child_properties_last, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';


class AppBtn extends StatefulWidget {
  final String? label;
  final Function? onClick;
  final bool disable;
  final String? disableAlertTitle;
  final String? disableAlertText;
  final Widget? anotherChild;
  final Widget defaultChild = Container();
  AppBtn({Key? key, this.label = "", this.onClick, this.anotherChild, this.disable=false, this.disableAlertTitle="", this.disableAlertText="",}) : super(key: key);
  @override
  _AppBtnState createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> with SingleTickerProviderStateMixin {
  double? _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void _showDialog(String content,String title) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("اغلق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    Widget contentList = Row(
      mainAxisAlignment: widget.anotherChild == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "${widget.label}",

              style: buttonStyleMain,
            ),
          ),
        ),
        widget.anotherChild == null ? widget.defaultChild : widget.anotherChild!
      ],
    );

    return GestureDetector(

        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Transform.scale(
          scale: _scale,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: widget.disable?Colors.grey:mainColor,
            child: InkWell(
              splashColor: widget.disable?Colors.grey:mainColor,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  alignment: Alignment.center,
                  child: contentList),
              onTap: widget.disable?(){_showDialog(widget.disableAlertText??"", widget.disableAlertTitle??"");}:widget.onClick as void Function()?,
            ),
          ),
        ));
  }
}
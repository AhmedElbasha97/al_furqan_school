// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';


class AppBtn extends StatefulWidget {
  final String? label;
  final Function? onClick;
  final Widget? anotherChild;
  // used as [anotherChild] default valuse when [anotherChild] == null
  final Widget defaultChild = Container();
  AppBtn({Key? key, this.label = "", this.onClick, this.anotherChild}) : super(key: key);
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
    //List of children placed inside button
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
            color: mainColor,
            child: InkWell(
              splashColor: mainColor,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  alignment: Alignment.center,
                  child: contentList),
              onTap: widget.onClick as void Function()?,
            ),
          ),
        ));
  }
}
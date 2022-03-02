// ignore_for_file: file_names
import 'package:flutter/material.dart';

class UICard extends StatefulWidget {
  final Widget? cardContent;
  final Color? borderColor;
  const UICard({Key? key,  this.cardContent, this.borderColor}) : super(key: key);

  @override
  _UICardState createState() => _UICardState();
}

class _UICardState extends State<UICard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.borderColor ?? Colors.white,
              width: widget.borderColor == null ? 1 : 4),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Material(
        elevation: 3,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: widget.cardContent,
      ),
    );
  }
}

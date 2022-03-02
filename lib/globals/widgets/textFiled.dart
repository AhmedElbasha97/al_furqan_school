// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';

class InputFiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType inputType;
   const InputFiled(
      {Key? key, this.controller, this.hintText, this.inputType = TextInputType.text}) : super(key: key);
  @override
  _InputFiledState createState() => _InputFiledState();
}

class _InputFiledState extends State<InputFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        keyboardType: widget.inputType,
        controller: widget.controller,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: mainColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: mainColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: mainColor)),
            hintText: widget.hintText),
      ),
    );
  }
}

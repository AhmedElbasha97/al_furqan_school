// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:al_furqan_school/globals/commonStyles.dart';

class InputFiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType inputType;
  final bool isPasswordFiled;
   const InputFiled(
      {Key? key, this.controller, this.hintText, this.inputType = TextInputType.text,  this.isPasswordFiled=false}) : super(key: key);
  @override
  _InputFiledState createState() => _InputFiledState();
}

class _InputFiledState extends State<InputFiled> {
  bool passwordVisible = false ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        obscureText: widget.isPasswordFiled?passwordVisible:false,
        keyboardType: widget.inputType,
        controller: widget.controller,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            suffixIcon: widget.isPasswordFiled?IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,color: mainColor,),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                }):Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,color: Colors.transparent,size: 1,),

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

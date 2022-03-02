// ignore_for_file: file_names

import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////
/// Colors
///////////////////////////////////////////////////////////
Color mainColor = const Color(0xFF8A1538);
Color mainTextColor = const Color(0xFF0c1f38);
Color accent = Colors.cyan;
Color teal = const Color(0xFF97BFB4);
Color white = const Color(0xFFF5EEDC);
Color splash = Colors.blue;

///////////////////////////////////////////////////////////
/// theme
///////////////////////////////////////////////////////////
ThemeData appTheme = ThemeData(
    appBarTheme: appBarTheme,
    brightness: appBrightness,
    fontFamily: "DroidKufi");

Brightness appBrightness = Brightness.light;

AppBarTheme appBarTheme = AppBarTheme(
  color: accent,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  elevation: 0.0,
);

///////////////////////////////////////////////////////////
/// Text Styles
///////////////////////////////////////////////////////////
TextStyle appText =
    TextStyle(color: white, fontWeight: FontWeight.w300, fontSize: 15);
TextStyle appBarAccent =
     TextStyle(color: white, fontWeight: FontWeight.w300, fontSize: 20);

TextStyle buttonStyleMain = TextStyle(color: white, fontSize: 20);
TextStyle buttonStyleAccent = TextStyle(color: teal, fontSize: 20);

///////////////////////////////////////////////////////////
/// Applinks
///////////////////////////////////////////////////////////
String androidStoreLink = "";
String iosStoreLink = "";

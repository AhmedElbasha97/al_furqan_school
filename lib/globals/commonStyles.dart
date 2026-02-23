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
 const primaryColor = Colors.indigo;
 const lightBackground = Colors.white;
 const darkBackground = Color(0xFF121212);

// Text colors
 const lightTextColor = Colors.black87;
 const darkTextColor = Colors.white70;

// Custom brand color (your color)
 const brandColor = Color(0xFF7e2670);

// 🌟 Custom state colors
 const selectedColorLight = Color(0xFF3949AB);
 const unselectedColorLight = Colors.grey;

 const selectedColorDark = Color(0xFF90CAF9);
 const unselectedColorDark = Colors.grey;


///////////////////////////////////////////////////////////
/// theme
///////////////////////////////////////////////////////////
ThemeData appTheme = ThemeData(
    appBarTheme: appBarTheme,
    brightness: appBrightness,
    fontFamily: "DroidKufi");

Brightness appBrightness = Brightness.light;

class ScreenHelper {
  // رجع العرض الكامل للشاشة
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // رجع الطول الفعلي بدون status bar و navigation bar
  static double usableHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // المساحة المشغولة بالـ status bar و navigation bar
    final padding = MediaQuery.of(context).padding;
    final statusBarHeight = padding.top;
    final navigationBarHeight = padding.bottom;

    // الطول الفعلي بدون status bar و navigation bar
    return screenHeight - statusBarHeight - navigationBarHeight;
  }

  // لو عايز ترجع الطول بدون status bar بس
  static double heightWithoutStatusBar(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    return size - padding.top;
  }

  // لو عايز الطول بدون AppBar كمان
  static double heightWithoutAppBar(BuildContext context, {double appBarHeight = kToolbarHeight}) {
    final size = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    return size - padding.top - padding.bottom - appBarHeight;
  }
}
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

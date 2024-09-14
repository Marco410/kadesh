import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class ColorsStyle {
  static const primaryColor = Color(0xff03C9F3);
  static const secondaryColor = Color(0xff01F363);
  static const thirdColor = Color(0xffFFF6E9);
  static const hintColor = Color(0xFFC5C6CC);
  static const hintWhite = Color(0xFFC4C4C4);
  static const hintDarkColor = Color(0xFF8F9098);
  static const dark = Color(0xff1E1E1E);
}

class TxtStyle {
  static final headerStyle = TextStyle(
      fontFamily: "Poppins",
      fontSize: 10.f,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
      letterSpacing: 1.5);

  static final descriptionStyle = TextStyle(
      fontFamily: "Sans",
      fontSize: 6.f,
      color: ColorsStyle.hintDarkColor,
      letterSpacing: 1.5,
      wordSpacing: 2,
      fontWeight: FontWeight.w400);

  static final labelStyle = TextStyle(
      fontFamily: "Poppins",
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 4.5.f);

  static final hintText = TextStyle(
      color: ColorsStyle.hintDarkColor,
      fontSize: 4.f,
      fontWeight: FontWeight.bold);
}

class ShadowStyle {
  static const generalShadow = BoxShadow(
    color: Color(0x26AAA9A9),
    blurRadius: 8,
    spreadRadius: 2,
    offset: Offset(0, 6),
  );

  static BoxShadow containerShadow = BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 4,
      spreadRadius: 0,
      offset: const Offset(0, 0));
}

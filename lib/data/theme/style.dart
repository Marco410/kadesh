import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class ColorsStyle {
  static const primaryColor = Color(0xffF7945E);
  static const secondaryColor = Color(0xffA99286);
  static const thirdColor = Color(0xffF4DFD8);
  static const primaryLightColor = Color(0xffFCE2D2);
  static const hintColor = Color(0xFFC5C6CC);
  static const hintWhite = Color(0xFFC4C4C4);
  static const hintDarkColor = Color(0xFF8F9098);
  static const dark = Color(0xff4D4E52);
  static const success = Color(0xFF31BC33);
  static const successLight = Color(0xFFE4FBD6);
  static const blue = Color(0xFF46AFFE);
  static const blueLight = Color(0xFFDBF7FF);
  static const warning = Color(0xFFFFB601);
  static const warningLight = Color(0xFFFFF6CC);
  static const error = Color(0xFFFF3A30);
  static const errorLight = Color(0xFFFFE5D5);
  static const white = Colors.white;
  static const background = Color(0xFFFFF9F2);
}

class TxtStyle {
  static final headerStyle = TextStyle(
      fontFamily: "Dongle",
      fontSize: 25.f,
      fontWeight: FontWeight.w800,
      color: ColorsStyle.dark,
      height: 0.7,
      letterSpacing: 1.5);

  static final descriptionStyle = TextStyle(
      fontFamily: "Sans",
      fontSize: 6.f,
      color: ColorsStyle.hintDarkColor,
      letterSpacing: 1.5,
      wordSpacing: 2,
      fontWeight: FontWeight.w400);

  static final labelStyle = TextStyle(
      fontFamily: "Dongle",
      color: ColorsStyle.dark,
      fontWeight: FontWeight.bold,
      fontSize: 10.f);

  static final hintText = TextStyle(
      color: ColorsStyle.hintDarkColor,
      fontSize: 4.f,
      fontWeight: FontWeight.bold);
}

class ShadowStyle {
  static List<BoxShadow> generalShadow = [
    const BoxShadow(
      color: Color(0x26AAA9A9),
      blurRadius: 8,
      spreadRadius: 2,
      offset: Offset(0, 6),
    )
  ];

  static List<BoxShadow> btnShadow = [
    const BoxShadow(
      color: Color(0x26AAA9A9),
      blurRadius: 5,
      spreadRadius: 1,
      offset: Offset(0, 0),
    )
  ];

  static List<BoxShadow> containerShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 4,
        spreadRadius: 0,
        offset: const Offset(0, 0))
  ];
}

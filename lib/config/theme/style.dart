import 'package:flutter/material.dart';

class ColorsStyle {
  static const primaryColor = Color(0xffF85046);
  static const secondaryColor = Color(0xffECF9FC);
  static const thirdColor = Color(0xffFFF6E9);
  static const hintColor = Color(0xFFC5C6CC);
  static const hintWhite = Color(0xFFC4C4C4);
  static const hintDarkColor = Color(0xFF8F9098);
  static const dark = Color(0xff1E1E1E);
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

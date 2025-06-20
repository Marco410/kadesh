// ignore_for_file: deprecated_member_use

import 'package:flutter/Material.dart';
import 'package:kadesh/data/theme/style.dart';

class CustomThemes {
  static final ThemeData lightTheme = ThemeData(
      fontFamily: "Popins",
      primaryColor: KColors.primaryColor,
      splashColor: KColors.primaryColor,
      chipTheme: const ChipThemeData(),
      useMaterial3: true,
      snackBarTheme: const SnackBarThemeData(),
      scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(Colors.transparent),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(KColors.primaryColor),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData());

  static final ThemeData darkTheme = ThemeData(
    fontFamily: "Popins",
    primaryColor: KColors.primaryColor,
    splashColor: Colors.white,
    chipTheme: const ChipThemeData(),
    useMaterial3: true,
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(Colors.transparent),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(selectionHandleColor: Colors.white),
  );
}

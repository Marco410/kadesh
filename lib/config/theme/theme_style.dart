import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xff585CE5),
  hintColor: Colors.black45,
  dividerColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: Color(0xffb41100),
    elevation: 0,
  ),
  textTheme: const TextTheme(
      labelLarge: TextStyle(
          fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w700),
      headlineSmall:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.white, fontSize: 18.3),
      bodyMedium: TextStyle(),
      titleSmall: TextStyle(color: Colors.black45)),
);

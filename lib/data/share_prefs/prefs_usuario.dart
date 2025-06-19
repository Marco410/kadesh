// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferenciasUsuarioProvider = Provider<PreferenciasUsuario>((ref) {
  return PreferenciasUsuario();
});

class PreferenciasUsuario with ChangeNotifier {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get show_onboarding {
    return _prefs.getBool("show_onboarding") ?? true;
  }

  set show_onboarding(bool value) {
    _prefs.setBool("show_onboarding", value);
  }

  String get userID {
    return _prefs.getString("userID") ?? "";
  }

  set userID(String value) {
    _prefs.setString("userID", value);
  }

  String get sessionToken {
    return _prefs.getString("sessionToken") ?? "";
  }

  set sessionToken(String value) {
    _prefs.setString("sessionToken", value);
  }

  String get name {
    return _prefs.getString("name") ?? "";
  }

  set name(String value) {
    _prefs.setString("name", value);
  }

  String get userName {
    return _prefs.getString("userName") ?? "";
  }

  set userName(String value) {
    _prefs.setString("userName", value);
  }

  String get lastName {
    return _prefs.getString("lastName") ?? "";
  }

  set lastName(String value) {
    _prefs.setString("lastName", value);
  }

  String get secondLastName {
    return _prefs.getString("secondLastName") ?? "";
  }

  set secondLastName(String value) {
    _prefs.setString("secondLastName", value);
  }

  String get email {
    return _prefs.getString("email") ?? "";
  }

  set email(String value) {
    _prefs.setString("email", value);
  }

  String? get phone {
    return _prefs.getString("phone") ?? "";
  }

  set phone(String? value) {
    _prefs.setString("phone", value ?? "");
  }

  String? get role {
    return _prefs.getString("role");
  }

  set role(String? value) {
    _prefs.setString("role", value ?? "");
  }

  String? get profileImage {
    return _prefs.getString("profileImage");
  }

  set profileImage(String? value) {
    _prefs.setString("profileImage", value ?? "");
  }

  String? get birthday {
    return _prefs.getString("birthday");
  }

  set birthday(String? value) {
    _prefs.setString("birthday", value ?? "");
  }

  String? get age {
    return _prefs.getString("age");
  }

  set age(String? value) {
    _prefs.setString("age", value ?? "");
  }
}

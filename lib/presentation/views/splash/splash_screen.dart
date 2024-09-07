// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/data/share_prefs/prefs_usuario.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  SplashScreenState();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();

  startTime() async {
    return Timer(const Duration(milliseconds: 3500), navigatorPage);
  }

  Future<void> navigatorPage() async {
    if (prefs.show_onboarding) {
      context.pushNamed('onboarding');
    } else {
      context.pushNamed('home');
    }
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: const Center(
          child: Icon(
        Icons.pedal_bike,
        size: 70,
        color: Colors.blueGrey,
      )),
    );
  }
}

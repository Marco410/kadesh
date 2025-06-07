import 'package:flutter/material.dart';
import 'package:pet_app/data/share_prefs/prefs_usuario.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () => prefs.show_onboarding = true,
                child: const Text("Home")),
            Text(prefs.userName),
            Text(prefs.email),
            Text(prefs.id),
          ],
        ),
      ),
    );
  }
}

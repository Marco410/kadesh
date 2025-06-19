import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kadesh/data/share_prefs/prefs_usuario.dart';

class Home2Screen extends ConsumerWidget {
  const Home2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferenciasUsuarioProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prefs.userName),
          Text(prefs.email),
        ],
      ),
    );
  }
}

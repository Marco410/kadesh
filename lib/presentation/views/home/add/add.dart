import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kadesh/presentation/widgets/custombutton.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Add"),
          CustomButton(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
              text: "Ir al inicio",
              onTap: () => context.go("/homeasdasd"),
              loading: false)
        ],
      ),
    );
  }
}

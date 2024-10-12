import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatefulWidget {
  final GoException? error;

  const ErrorScreen({super.key, this.error});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Página no encontrada",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          Text(widget.error!.message.toString()),

          /*  CustomButton(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
              text: "Ir al inicio",
              onTap: () => context.go("/"),
              loading: false) */
        ],
      ),
    );
  }
}

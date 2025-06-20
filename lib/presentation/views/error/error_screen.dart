import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:kadesh/presentation/widgets/custombutton.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer_pro/sizer.dart';

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
          Text(
            "Página no encontrada",
            textAlign: TextAlign.center,
            style: TxtStyle.headerStyle,
          ),
          Lottie.asset("assets/icons/animation/not-found.json", height: 25.h),
          const SizedBox(
            height: 60,
          ),
          Text(widget.error!.message.toString()),
          CustomButton(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              text: "Ir al inicio",
              onTap: () => context.goNamed("home"),
              loading: false)
        ],
      ),
    );
  }
}

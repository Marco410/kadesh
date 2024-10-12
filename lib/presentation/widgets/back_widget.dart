import 'package:flutter/material.dart';

class BackWidget extends StatelessWidget {
  final Widget widget;
  const BackWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            bottom: -150,
            left: 100,
            child: Image.asset("assets/backs/form2.png")),
        Positioned(
            top: -400,
            right: 200,
            child: Image.asset("assets/backs/form1.png")),
        widget,
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BackWidget extends StatelessWidget {
  final Widget widget;
  const BackWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /* Positioned(
            bottom: -150,
            left: 195,
            child: Hero(
                tag: 'form2', child: Image.asset("assets/backs/form2.png"))),
        Positioned(
            top: -400,
            right: 250,
            child: Hero(
                tag: 'form1',
                child: FadeAnimation(
                    child: Image.asset("assets/backs/form1.png")))), */
        widget,
      ],
    );
  }
}

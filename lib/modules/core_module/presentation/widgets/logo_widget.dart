import 'package:flutter/material.dart';
import 'package:kadesh/data/theme/style.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'logo',
      child: ImageIcon(AssetImage("assets/logo.png"),
          size: 120, color: KColors.primaryColor),
    );
  }
}

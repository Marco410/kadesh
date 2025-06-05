import 'package:flutter/material.dart';
import 'package:pet_app/data/theme/style.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(AssetImage("assets/logo.png"),
        size: 120, color: ColorsStyle.primaryColor);
  }
}

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kadesh/data/theme/style.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final HugeIcon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: KColors.white,
          shape: BoxShape.circle,
          boxShadow: ShadowStyle.containerShadow2,
        ),
        child: icon,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconColor = KColors.dark,
  });

  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: KColors.white,
          shape: BoxShape.circle,
          boxShadow: ShadowStyle.containerShadow2,
        ),
        child: HugeIcon(
          icon: icon,
          color: iconColor,
          size: 10.f,
        ),
      ),
    );
  }
}

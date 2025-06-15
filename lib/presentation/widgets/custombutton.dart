// ignore_for_file: must_be_immutable

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final Function() onTap;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final bool isDisabled;
  bool loading = false;
  String? size = 'md';
  Widget? icon;

  CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.textColor = Colors.white,
      this.width,
      this.margin,
      this.loading = false,
      this.isDisabled = false,
      this.size,
      this.icon,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FadedScaleAnimation(
      child: Bounceable(
        onTap: () {
          Haptics.vibrate(HapticsType.selection);
          onTap();
        },
        child: Container(
          width: width ?? double.infinity,
          margin: margin ??
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: isDisabled ? Colors.grey : color ?? theme.primaryColor,
              boxShadow: ShadowStyle.btnShadow,
              borderRadius: borderRadius ?? BorderRadius.circular(12)),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: (size == 'sm') ? 3.sp : 4.5.sp,
                  horizontal: (size == 'sm') ? 3.sp : 4.5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox(),
                  if (icon != null) const SizedBox(width: 10),
                  (loading)
                      ? LoadingStandardWidget.loadingWidget(20, Colors.white)
                      : Text(
                          text!,
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: (size == 'sm') ? 5.f : 7.f),
                          textAlign: TextAlign.center,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

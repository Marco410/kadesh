import 'package:flutter/material.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';
import 'package:toastification/toastification.dart';

class ToastUI {
  ToastUI._();

  static final instance = ToastUI._();

  void toastSuccess(String msg) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        'Éxito',
        style: TxtStyle.labelStyle
            .copyWith(color: Colors.green[900], fontSize: 12.f, height: 0.5),
      ),
      description: Text(
        msg,
        style: TxtStyle.labelStyle.copyWith(
            color: KColors.dark,
            fontSize: 11.f,
            height: 0.7,
            fontWeight: FontWeight.normal),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 500),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: true,
          child: child,
        );
      },
      icon: const Icon(
        Icons.check_circle_outline_outlined,
        color: KColors.success,
      ),
      showIcon: true,
      primaryColor: KColors.successLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      boxShadow: ShadowStyle.generalShadow,
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: KColors.success,
      ),
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  void toastError(String msg) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        'Algo inesperado',
        style: TxtStyle.labelStyle
            .copyWith(color: Colors.red[900], fontSize: 12.f, height: 0.5),
      ),
      description: Text(
        msg,
        style: TxtStyle.labelStyle.copyWith(
            color: KColors.dark,
            fontSize: 11.f,
            height: 0.7,
            fontWeight: FontWeight.normal),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 500),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: true,
          child: child,
        );
      },
      icon: const Icon(
        Icons.bug_report_rounded,
        color: KColors.error,
      ),
      showIcon: true,
      primaryColor: KColors.errorLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      boxShadow: ShadowStyle.generalShadow,
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: KColors.error,
      ),
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  void toastInfo(String msg) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        'Info.',
        style: TxtStyle.labelStyle
            .copyWith(color: Colors.blue[900], fontSize: 12.f, height: 0.5),
      ),
      description: Text(
        msg,
        style: TxtStyle.labelStyle.copyWith(
            color: KColors.dark,
            fontSize: 11.f,
            height: 0.7,
            fontWeight: FontWeight.normal),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 500),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: true,
          child: child,
        );
      },
      icon: const Icon(
        Icons.info_outline_rounded,
        color: KColors.blue,
      ),
      showIcon: true,
      primaryColor: KColors.blueLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      boxShadow: ShadowStyle.generalShadow,
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: KColors.blue,
      ),
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  void toastWarning(String msg) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        '¡Alerta!',
        style: TxtStyle.labelStyle
            .copyWith(color: KColors.warning, fontSize: 12.f, height: 0.5),
      ),
      description: Text(
        msg,
        style: TxtStyle.labelStyle.copyWith(
            color: KColors.dark,
            fontSize: 11.f,
            height: 0.7,
            fontWeight: FontWeight.normal),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 500),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: true,
          child: child,
        );
      },
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: KColors.warning,
      ),
      showIcon: true,
      primaryColor: KColors.warningLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      boxShadow: ShadowStyle.generalShadow,
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: KColors.warning,
      ),
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }
}

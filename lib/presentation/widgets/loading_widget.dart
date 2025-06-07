import 'package:flutter/Material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/data/theme/style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer_pro/sizer.dart';

class LoadingStandardWidget {
  static Widget loadingWidget([double? size, Color? color]) {
    return Center(
      child: LoadingAnimationWidget.threeRotatingDots(
        color: color ?? ColorStyle.primaryColor,
        size: size ?? 40,
      ),
    );
  }

  static Widget loadingEmptyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
            "https://lottie.host/ed3e3299-4a6c-4fcb-bacc-76f282cb7bf6/Aa82yIbK1k.json",
            height: 120,
            fit: BoxFit.contain),
        const Text(
          "No se encontraron resultados.",
          style: TextStyle(
              color: ColorStyle.primaryColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  static Widget loadingNoDataWidget(String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
            "https://lottie.host/be3e92cc-61e0-4c7c-9a27-164b3dc0989f/ztrZ8eSiOD.json",
            height: 120,
            fit: BoxFit.contain),
        Text(
          "No hay $type en este momento.",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ColorStyle.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ],
    );
  }

  static Widget loadingErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              "https://lottie.host/0f5bfd78-9ea4-4ab3-921f-c58d3efaf57e/8oUUsRf8Ry.json",
              height: 100,
              fit: BoxFit.contain),
          const SizedBox(
            height: 15,
          ),
          Text(
            "¡Ups! Algo salió mal con la comunicación. \nInténtalo de nuevo más tarde, por favor.",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static Widget skeleton(
      {double? size = 25,
      int rows = 3,
      int columnsPerRow = 2,
      IconData? icon}) {
    return Column(
      spacing: 15,
      children: List.generate(rows, (rowIndex) {
        return Row(
          spacing: 10,
          children: List.generate(columnsPerRow, (columnIndex) {
            return Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: ColorStyle.hintColor,
                    highlightColor: ColorStyle.hintLightColor,
                    child: Container(
                      height: size?.h ?? 25.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey),
                    ),
                  ),
                  icon != null
                      ? Icon(
                          icon,
                          color: ColorStyle.hintLightColor,
                          size: (size?.h ?? 25.h) / 4,
                        )
                      : const SizedBox(),
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}

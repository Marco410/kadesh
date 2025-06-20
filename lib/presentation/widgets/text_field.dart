// ignore_for_file: unnecessary_string_escapes, must_be_immutable

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  List<TextInputFormatter>? formatters;
  final String? suffixText;
  final IconButton? suffixIcon;
  final EdgeInsets? margin;
  final IconData? prefixIcon;
  final Color? color;
  final String label;
  final Color? labelColor;
  final bool border;
  final Function? onTap;
  final bool isVisible;
  final int? lines;
  TextEditingController? controller = TextEditingController();
  TextInputType textInputType;
  final bool isRequired;
  final FocusNode? focusNode;
  final bool? readOnly;
  final Function(String value)? onChange;
  final bool hasError;
  final String errorText;

  TextFieldWidget(
      {super.key,
      this.formatters,
      this.suffixText,
      this.isVisible = true,
      this.labelColor = KColors.dark,
      this.border = true,
      this.suffixIcon,
      this.margin,
      this.prefixIcon,
      this.color,
      this.onTap,
      this.controller,
      this.lines,
      this.readOnly = false,
      this.onChange,
      this.focusNode,
      this.isRequired = true,
      this.textInputType = TextInputType.text,
      this.hintText = "Escribe aquí",
      required this.label,
      this.hasError = false,
      this.errorText = ""});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FormField(
      validator: (input) {
        if (textInputType == TextInputType.emailAddress) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if (isRequired) {
            if (controller!.text == "") {
              return "Requerido";
            }
            if (regExp.hasMatch(controller!.text)) {
              return null;
            } else {
              return "Correo electrónico inválido";
            }
          }
        } else if (textInputType == TextInputType.text) {
          if (isRequired) {
            if (controller!.text == "") {
              return "Requerido";
            }
          }

          if (label == 'CURP') {
            if (controller!.text != "") {
              String pattern =
                  r"^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$";
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(controller!.text)
                  ? null
                  : "Inserte una curp valida";
            }
          }
        } else if (textInputType == TextInputType.number) {
          if (isRequired) {
            if (controller!.text == "") {
              return "Requerido";
            }
            if (label == 'Celular') {
              if (controller!.text.length != 10) {
                return "Debe de ser de 10 dígitos";
              }
            }
          }
        } else if (textInputType == TextInputType.datetime) {
          if (isRequired) {
            if (controller!.text == "") {
              return "Requerido";
            }
          }
        }

        if (isRequired && controller!.text.isEmpty) {
          return "Requerido";
        }

        return null;
      },
      builder: (formField) {
        return FadedScaleAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (label != "")
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Text(
                        '$label ${(isRequired) ? "*" : ""}',
                        style: TxtStyle.labelStyle.copyWith(color: labelColor),
                      ),
                    )
                  : const SizedBox(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  border: border
                      ? Border.all(
                          color: (formField.hasError || hasError)
                              ? KColors.error
                              : KColors.hintColor)
                      : Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    (!border)
                        ? BoxShadow(
                            color: (formField.hasError || hasError)
                                ? KColors.error.withOpacity(0.7)
                                : KColors.dark.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: -5,
                            offset: const Offset(2, 4))
                        : const BoxShadow()
                  ],
                ),
                child: TextField(
                  readOnly: readOnly!,
                  inputFormatters: formatters,
                  autofocus: false,
                  controller: controller,
                  keyboardType: textInputType,
                  style: TextStyle(
                      color: (readOnly!)
                          ? (textInputType == TextInputType.datetime)
                              ? KColors.dark
                              : Colors.grey
                          : KColors.dark,
                      fontSize: 7.f),
                  onTap: onTap as void Function()?,
                  maxLines: lines ?? 1,
                  textInputAction: TextInputAction.done,
                  focusNode: focusNode,
                  onChanged: (onChange != null) ? onChange : null,
                  obscureText: !isVisible,
                  textCapitalization:
                      (textInputType != TextInputType.emailAddress)
                          ? TextCapitalization.sentences
                          : TextCapitalization.none,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle:
                          theme.textTheme.titleSmall!.copyWith(fontSize: 6.f),
                      enabledBorder: InputBorder.none,
                      suffixText: suffixText,
                      suffixStyle: TxtStyle.hintText.copyWith(
                          color: KColors.primaryColor, fontSize: 4.5.sp),
                      suffixIcon: suffixIcon,
                      focusColor: Colors.black),
                ),
              ),
              (formField.hasError || hasError)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 15, top: 7),
                      child: Text(
                        formField.errorText ?? errorText,
                        style: TextStyle(color: Colors.red, fontSize: 4.5.sp),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

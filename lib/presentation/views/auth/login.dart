import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:pet_app/data/share_prefs/prefs_usuario.dart';
import 'package:pet_app/data/theme/style.dart';
import 'package:pet_app/domain/mutations/auth.dart';
import 'package:pet_app/domain/services/notifications.dart';
import 'package:pet_app/presentation/widgets/back_widget.dart';
import 'package:pet_app/presentation/widgets/custombutton.dart';
import 'package:pet_app/presentation/widgets/text_field.dart';
import 'package:sizer_pro/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: BackWidget(
          widget: Container(
              alignment: Alignment.center,
              height: 100.h,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "¡Bienvenido!",
                        style: TxtStyle.headerStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Comienza iniciando sesión.",
                        style: TxtStyle.labelStyle,
                      ),
                      const SizedBox(height: 25),
                      TextFieldWidget(
                        label: "Correo electrónico",
                        border: false,
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        label: "Contraseña",
                        border: false,
                        textInputType: TextInputType.text,
                        isVisible: isVisible,
                        controller: passwordController,
                        suffixIcon: IconButton(
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text("¿Olvidaste tu contraseña?",
                          style: TxtStyle.labelStyle.copyWith(
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline)),
                      Mutation(
                        options: MutationOptions(
                          document: gql(AuthMutations.loginMutation),
                          onCompleted: (dynamic resultData) {
                            print("resultData");
                            print(resultData);
                            print(resultData["authenticateUserWithPassword"]);

                            if (resultData["authenticateUserWithPassword"]
                                    ["__typename"] ==
                                "UserAuthenticationWithPasswordFailure") {
                              ToastUI.instance.toastError(
                                  "Usuario o contraseña incorrectos.");
                              return;
                            }

                            /*  final resp = json.encode(resultData);
                            print("resp");
                            print(resp); */
                            prefs.show_onboarding = true;
                            context.go('home');
                          },
                        ),
                        builder: (runMutation, result) {
                          return CustomButton(
                            text: "Inciar sesión",
                            margin: const EdgeInsets.only(top: 15, bottom: 10),
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                ToastUI.instance.toastWarning(
                                    "Ingresa los datos requeridos.");
                                return;
                              }
                              final data = {
                                "email": emailController.text,
                                "password": passwordController.text
                              };
                              runMutation(data);
                            },
                          );
                        },
                      ),
                      Text(
                        "Continuar sin iniciar sesión",
                        style: TxtStyle.labelStyle.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              color: ColorsStyle.hintColor,
                              height: 2,
                            ),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text(
                                "o",
                                style:
                                    TextStyle(color: ColorsStyle.hintDarkColor),
                              )),
                          Expanded(
                            child: Container(
                              color: ColorsStyle.hintColor,
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButtonWidget(
                            icon: 'facebook',
                            iconColor: Colors.blue,
                          ),
                          SizedBox(width: 25),
                          IconButtonWidget(
                            icon: 'google',
                            iconColor: Colors.redAccent,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final Color color;
  final String icon;
  final Function()? onTap;
  final bool isDisabled;
  final Color iconColor;
  final double borderRadius;

  const IconButtonWidget({
    super.key,
    this.onTap,
    this.borderRadius = 10,
    this.isDisabled = false,
    this.color = Colors.white,
    this.iconColor = ColorsStyle.primaryColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Haptics.vibrate(HapticsType.selection);
        isDisabled ? null : onTap as void Function()?;
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: ShadowStyle.generalShadow),
        child: SvgPicture.asset("assets/icons/$icon.svg",
            height: 23, color: iconColor),
      ),
    );
  }
}

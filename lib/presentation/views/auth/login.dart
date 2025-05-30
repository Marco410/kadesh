import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pet_app/data/theme/style.dart';
import 'package:pet_app/domain/controllers/auth_controller.dart';
import 'package:pet_app/domain/mutations/auth.dart';
import 'package:pet_app/domain/services/notifications.dart';
import 'package:pet_app/presentation/widgets/back_widget.dart';
import 'package:pet_app/presentation/widgets/custombutton.dart';
import 'package:pet_app/presentation/widgets/social_media_auth.dart';
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
    emailController.text = "marco_pascual410@hotmail.com";
    passwordController.text = "1234567890";

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
                            if (resultData["authenticateUserWithPassword"]
                                    ["__typename"] ==
                                "UserAuthenticationWithPasswordFailure") {
                              ToastUI.instance.toastError(
                                  "Usuario o contraseña incorrectos.");
                              return;
                            }

                            final resp = AuthController.login(
                                resultData["authenticateUserWithPassword"]);

                            if (resp) {
                              context.goNamed('home');
                            } else {
                              ToastUI.instance
                                  .toastError("Intente de nuevo más tarde.");
                            }
                          },
                        ),
                        builder: (runMutation, result) {
                          if (result!.hasException) {
                            return const SizedBox();
                          }
                          return CustomButton(
                            text: "Inciar sesión",
                            margin: const EdgeInsets.only(top: 15, bottom: 5),
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
                            loading: result.isLoading,
                          );
                        },
                      ),
                      CustomButton(
                        text: "Registrate",
                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                        onTap: () => context.goNamed('register'),
                        color: Colors.white,
                        textColor: ColorsStyle.primaryColor,
                        loading: false,
                      ),
                      Bounceable(
                        onTap: () => context.pushNamed('home'),
                        child: Text(
                          "Continuar sin iniciar sesión",
                          style: TxtStyle.labelStyle.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const SocialMediaAuth()
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kadesh/data/helpers/handle_errors.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:kadesh/domain/mutations/auth.dart';
import 'package:kadesh/domain/queries/auth.dart';
import 'package:kadesh/domain/services/notifications.dart';
import 'package:kadesh/presentation/widgets/back_widget.dart';
import 'package:kadesh/presentation/widgets/custombutton.dart';
import 'package:kadesh/presentation/widgets/social_media_auth.dart';
import 'package:kadesh/presentation/widgets/text_field.dart';
import 'package:sizer_pro/sizer.dart';

import '../../../domain/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final client = GraphQLProvider.of(context).value;
    return Scaffold(
      backgroundColor: KColors.background,
      extendBodyBehindAppBar: false,
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
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 65),
                      Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: ShadowStyle.btnShadow,
                                borderRadius: BorderRadius.circular(8)),
                            child: IconButton(
                                icon: const Icon(Icons.arrow_back_rounded,
                                    color: KColors.primaryColor, size: 26),
                                onPressed: () => context.pop()),
                          ),
                        ],
                      ),
                      const LogoWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "¡Comencemos con el registro!",
                          style: TxtStyle.headerStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const SocialMediaAuth(
                        lineAtTop: false,
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              label: "Nombre",
                              border: false,
                              textInputType: TextInputType.text,
                              controller: nameController,
                              onChange: (v) {
                                Random random = Random();
                                setState(() {
                                  userNameController.text =
                                      "${v.trim().toLowerCase()} ${lastNameController.text.trim().toLowerCase()}${random.nextInt(99)}"
                                          .replaceAll(" ", ".");
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFieldWidget(
                              label: "Apellido",
                              border: false,
                              textInputType: TextInputType.text,
                              controller: lastNameController,
                              isRequired: true,
                              onChange: (v) {
                                Random random = Random();
                                setState(() {
                                  userNameController.text =
                                      "${nameController.text.trim().toLowerCase()} ${v.trim().toLowerCase()}${random.nextInt(99)}"
                                          .replaceAll(" ", ".");
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Query(
                          options: QueryOptions(
                              document: gql(AuthQueries.searchUserName),
                              variables: {
                                "where": {"username": userNameController.text}
                              }),
                          builder: (result, {fetchMore, refetch}) {
                            bool hasUser = result.data != null &&
                                result.data!['user'] != null &&
                                result.data!['user'].isNotEmpty;

                            return Column(
                              children: [
                                TextFieldWidget(
                                  label: "Nombre de usuario",
                                  border: false,
                                  textInputType: TextInputType.text,
                                  controller: userNameController,
                                  hasError: hasUser,
                                  errorText:
                                      "Este nombre de usuario ya esta siendo utilizado",
                                  onChange: (v) {
                                    setState(() {
                                      userNameController.text = v
                                          .toLowerCase()
                                          .trim()
                                          .replaceAll(" ", "");
                                    });
                                  },
                                ),
                              ],
                            );
                          }),
                      /*  const SizedBox(height: 15),
                      TextFieldWidget(
                        label: "Teléfono",
                        border: false,
                        textInputType: TextInputType.number,
                        controller: phoneController,
                      ), */
                      /*  const SizedBox(height: 15),
                      TextFieldWidget(
                        label: 'Fecha de nacimiento',
                        border: false,
                        labelColor: Colors.black,
                        hintText: "dd/mm/aaaa",
                        color: Colors.white,
                        controller: birthController,
                        onTap: () async {
                          final res = await DateHelper.selectDate(context);

                          if (res != null) {
                            birthController.text = res;
                          }
                        },
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: KColors.secondaryColor,
                          ),
                          onPressed: () async {
                            final res = await DateHelper.selectDate(context);

                            if (res != null) {
                              birthController.text = res;
                            }
                          },
                        ),
                        readOnly: true,
                        textInputType: TextInputType.datetime,
                        isRequired: true,
                      ), */
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        label: "Correo electrónico",
                        border: false,
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        onChange: (value) =>
                            emailController.text = value.toLowerCase(),
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
                      TextFieldWidget(
                        label: "Confirmar contraseña",
                        border: false,
                        textInputType: TextInputType.text,
                        isVisible: isVisible,
                        controller: passwordConfirmController,
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
                      Mutation(
                        options: MutationOptions(
                          document: gql(AuthMutations.createUser),
                          onCompleted: (resultData) async {
                            if (resultData == null) return;

                            try {
                              final loginResult = await client.mutate(
                                MutationOptions(
                                  document: gql(AuthMutations.loginMutation),
                                  variables: {
                                    "email": emailController.text.trim(),
                                    "password": passwordController.text,
                                  },
                                ),
                              );

                              final authData = loginResult
                                  .data?["authenticateUserWithPassword"];
                              if (authData == null) {
                                ToastUI.instance.toastError(
                                    "Error al iniciar sesión. Intenta más tarde.");
                                return;
                              }

                              final success =
                                  AuthController.loginSaveData(authData);
                              if (success) {
                                if (context.mounted) {
                                  context.goNamed('home');
                                }
                              } else {
                                ToastUI.instance
                                    .toastError("Intente de nuevo más tarde.");
                              }
                            } catch (e) {
                              ToastUI.instance.toastError(
                                  "Error inesperado. Intenta más tarde.");
                            }
                          },
                          onError: (error) {
                            final errorMsg = handleGraphQLError(error);
                            ToastUI.instance.toastError(errorMsg);
                          },
                        ),
                        builder: (runMutation, result) {
                          final isLoading = result?.isLoading ?? false;

                          return CustomButton(
                            text: "Registrarme",
                            margin: const EdgeInsets.only(top: 15, bottom: 10),
                            loading: isLoading,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                ToastUI.instance.toastWarning(
                                    "Ingresa los datos requeridos.");
                                return;
                              }

                              final password = passwordController.text;
                              final confirmPassword =
                                  passwordConfirmController.text;

                              if (password != confirmPassword) {
                                ToastUI.instance.toastWarning(
                                    "Las contraseñas deben coincidir.");
                                return;
                              }

                              if (password.length < 8) {
                                ToastUI.instance.toastWarning(
                                    "La contraseña debe tener al menos 8 caracteres.");
                                return;
                              }

                              final data = {
                                "data": {
                                  "email": emailController.text.trim(),
                                  "password": password,
                                  "name": nameController.text.trim(),
                                  "lastName": lastNameController.text.trim(),
                                  "username": userNameController.text
                                },
                              };

                              runMutation(data);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Bounceable(
                        onTap: () => context.pop(),
                        child: Text(
                          "Regresar al login",
                          style: TxtStyle.labelStyle.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 45),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

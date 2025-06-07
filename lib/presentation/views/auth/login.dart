import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kadesh/data/helpers/handle_errors.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:kadesh/domain/controllers/auth_controller.dart';
import 'package:kadesh/domain/mutations/auth.dart';
import 'package:kadesh/domain/providers/video_provider.dart';
import 'package:kadesh/domain/services/notifications.dart';
import 'package:kadesh/presentation/widgets/back_widget.dart';
import 'package:kadesh/presentation/widgets/custombutton.dart';
import 'package:kadesh/presentation/widgets/social_media_auth.dart';
import 'package:kadesh/presentation/widgets/text_field.dart';
import 'package:sizer_pro/sizer.dart';
import 'package:video_player/video_player.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(videoControllerProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = "marco_pascual410@hotmail.com";
    passwordController.text = "1234567890";
    final videoControllerAsyncValue = ref.watch(videoControllerProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: SizedBox.expand(
              child: videoControllerAsyncValue.when(
                  data: (controller) => VideoPlayer(controller),
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const SizedBox())),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.4), // Ajusta opacidad aquí
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: const BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const LogoWidget(),
                          Text(
                            "¡Bienvenido!",
                            style: TxtStyle.headerStyle
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Comienza iniciando sesión.",
                            style: TxtStyle.labelStyle
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 25),
                          TextFieldWidget(
                            label: "Correo electrónico",
                            border: false,
                            textInputType: TextInputType.emailAddress,
                            controller: emailController,
                            labelColor: Colors.white,
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
                            labelColor: Colors.white,
                          ),
                          const SizedBox(height: 15),
                          Text("¿Olvidaste tu contraseña?",
                              style: TxtStyle.labelStyle.copyWith(
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline,
                                  color: Colors.white)),
                          Mutation(
                            options: MutationOptions(
                              document: gql(AuthMutations.loginMutation),
                              onCompleted: (resultData) {
                                final response =
                                    resultData?["authenticateUserWithPassword"];

                                if (response == null) {
                                  ToastUI.instance.toastError(
                                      "Error inesperado. Intente más tarde.");
                                  return;
                                }

                                final typename = response["__typename"];

                                if (typename ==
                                    "UserAuthenticationWithPasswordFailure") {
                                  ToastUI.instance.toastError(
                                      "Usuario o contraseña incorrectos.");
                                  return;
                                }

                                final success =
                                    AuthController.loginSaveData(response);

                                if (success) {
                                  context.goNamed('home');
                                } else {
                                  ToastUI.instance.toastError(
                                      "Intente de nuevo más tarde.");
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
                                text: "Iniciar sesión",
                                margin:
                                    const EdgeInsets.only(top: 15, bottom: 5),
                                loading: isLoading,
                                onTap: () {
                                  if (!_formKey.currentState!.validate()) {
                                    ToastUI.instance.toastWarning(
                                        "Ingresa los datos requeridos.");
                                    return;
                                  }

                                  final email = emailController.text.trim();
                                  final password = passwordController.text;

                                  runMutation({
                                    "email": email,
                                    "password": password,
                                  });
                                },
                              );
                            },
                          ),
                          CustomButton(
                            text: "Registrate",
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            onTap: () => context.goNamed('register'),
                            color: Colors.white,
                            textColor: KColors.primaryColor,
                            loading: false,
                          ),
                          Bounceable(
                            onTap: () => context.pushNamed('home'),
                            child: Text(
                              "Continuar sin iniciar sesión",
                              style: TxtStyle.labelStyle.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
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
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_app/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 100.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                ColorsStyle.primaryColor,
                ColorsStyle.secondaryColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(color: ColorsStyle.hintWhite),
                child: Text("Login"),
              )
            ],
          )),
    );
  }
}

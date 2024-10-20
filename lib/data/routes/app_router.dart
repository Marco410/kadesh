import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/screens.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/',
      errorBuilder: (context, state) => ErrorScreen(error: state.error),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const Onbording(),
        ),
        GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                name: 'register',
                path: 'register',
                builder: (context, state) => const RegisterScreen(),
              )
            ]),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
      ]);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/presentation/views/home.dart';
import 'package:pet_app/presentation/views/onboarding/onboarding.dart';
import 'package:pet_app/presentation/views/splash/splash_screen.dart';
import 'package:pet_app/presentation/views/error/error_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
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
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
      ]);
});

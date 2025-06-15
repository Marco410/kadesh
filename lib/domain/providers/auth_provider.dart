// auth_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_app/domain/services/notifications.dart';
import '../services/auth_service.dart';
import '../controllers/auth_controller.dart';

final googleAuthProvider = AsyncNotifierProvider<GoogleAuthNotifier, void>(
  GoogleAuthNotifier.new,
);

class GoogleAuthNotifier extends AsyncNotifier<void> {
  final _authService = AuthService();

  @override
  Future<void> build() async {}

  Future<bool> loginWithGoogle() async {
    state = const AsyncLoading();

    try {
      final user = await _authService.signInWithGoogle();

      if (user == null) {
        state = const AsyncData(null);
        ToastUI.instance.toastWarning("Inicio de sesión cancelado.");
        return false;
      }

      final success = AuthController.customLoginSaveData(user);

      if (success) {
        state = const AsyncData(null);
        return true;
      } else {
        state = const AsyncData(null);
        ToastUI.instance.toastError("Intente de nuevo más tarde.");
        return false;
      }
    } on Exception {
      state = const AsyncData(null);

      ToastUI.instance.toastError("Ocurrió un error al iniciar sesión.");
      return false;
    }
  }
}

final facebookAuthProvider = AsyncNotifierProvider<FacebookAuthNotifier, void>(
  FacebookAuthNotifier.new,
);

class FacebookAuthNotifier extends AsyncNotifier<void> {
  final _authService = AuthService();

  @override
  Future<void> build() async {}

  Future<bool> loginWithFacebook() async {
    state = const AsyncLoading();

    try {
      final user = await _authService.signInWithFacebook();

      if (user == null) {
        state = const AsyncData(null);
        ToastUI.instance.toastWarning("Inicio de sesión cancelado.");
        return false;
      }

      final success = AuthController.customLoginSaveData(user);

      if (success) {
        state = const AsyncData(null);
        return true;
      } else {
        state = const AsyncData(null);
        ToastUI.instance.toastError("Intente de nuevo más tarde.");
        return false;
      }
    } on Exception {
      state = const AsyncData(null);

      ToastUI.instance.toastError("Ocurrió un error al iniciar sesión.");
      return false;
    }
  }
}

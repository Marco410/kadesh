import 'package:kadesh/data/models/user.dart';
import 'package:kadesh/data/share_prefs/prefs_usuario.dart';

class AuthController {
  static bool loginSaveData(dynamic data) {
    try {
      final prefs = PreferenciasUsuario();

      if (data == null || data["item"] == null) return false;

      final item = data["item"] as Map<String, dynamic>;

      prefs.sessionToken = data["sessionToken"] ?? '';
      prefs.name = item["name"] ?? '';
      prefs.lastName = item["lastName"] ?? '';
      prefs.secondLastName = item["secondLastName"] ?? '';
      prefs.userName = item["username"] ?? '';
      prefs.email = item["email"] ?? '';
      prefs.phone = item["phone"] ?? '';
      prefs.role = item["role"] ?? '';
      prefs.profileImage = item["profileImage"] ?? '';
      prefs.birthday = item["birthday"] ?? '';
      prefs.age = item["age"] ?? 0;

      return true;
    } catch (e) {
      return false;
    }
  }

  static bool customLoginSaveData(KUser user) {
    try {
      final prefs = PreferenciasUsuario();

      prefs
        ..sessionToken = user.sessionToken
        ..id = user.id
        ..name = user.name
        ..lastName = user.lastName
        ..secondLastName = user.secondLastName ?? ''
        ..verified = user.verified ?? false
        ..userName = user.username
        ..email = user.email
        ..phone = user.phone ?? ''
        ..role = user.role
        ..profileImage = user.profileImage?.url ?? ''
        ..birthday = user.birthday ?? ''
        ..age = user.age ?? 0;

      return true;
    } catch (e) {
      return false;
    }
  }
}

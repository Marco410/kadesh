import 'package:kadesh/data/share_prefs/prefs_usuario.dart';

class AuthController {
  static bool login(dynamic data) {
    try {
      final prefs = PreferenciasUsuario();
      prefs.sessionToken = data["sessionToken"];
      prefs.name = data["item"]["name"];
      prefs.lastName = data["item"]["lastName"];
      prefs.secondLastName = data["item"]["secondLastName"];
      prefs.userName = data["item"]["username"];
      prefs.email = data["item"]["email"];
      prefs.phone = data["item"]["phone"];
      prefs.role = data["item"]["role"];
      prefs.profileImage = data["item"]["profileImage"];
      prefs.birthday = data["item"]["birthday"];
      prefs.age = data["item"]["age"];

      return true;
    } catch (e) {
      return false;
    }
  }
}

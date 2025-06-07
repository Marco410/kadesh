import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_app/data/models/user.dart';
import 'package:pet_app/domain/mutations/auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<KUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final dio = Dio();
      final response = await dio.post(
        dotenv.env['API_LINK']!,
        data: {
          'query': AuthMutations.customLoginMutation,
          'variables': {
            'email': userCredential.user!.email,
            'name': userCredential.user!.displayName!.split(" ")[0],
            'lastName': userCredential.user!.displayName!.split(" ")[1],
          },
        },
      );

      final data = response.data['data']['customAuth']['data'];
      return KUser.fromJson(data);
    } on FirebaseAuthException catch (e) {
      print("Error de autenticación de Firebase: ${e.message}");
      return null;
    } catch (e) {
      print("Error al iniciar sesión con Google: $e");
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}

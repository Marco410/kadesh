import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kadesh/data/models/user.dart';
import 'package:kadesh/domain/mutations/auth.dart';

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

      final displayName = userCredential.user!.displayName ?? '';
      final parts = displayName.trim().split(" ");

      final name = parts.isNotEmpty ? parts[0] : '';
      final lastName = parts.length > 1 ? parts.sublist(1).join(" ") : 'Kadesh';

      final dio = Dio();
      final response = await dio.post(
        dotenv.env['API_LINK']!,
        data: {
          'query': AuthMutations.customLoginMutation,
          'variables': {
            'email': userCredential.user!.email,
            'name': name,
            'lastName': lastName,
          },
        },
      );

      final data = response.data['data']['customAuth']['data'];
      return KUser.fromJson(data);
    } on FirebaseAuthException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<KUser?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();

        final displayName = userData["name"] ?? '';
        final parts = displayName.trim().split(" ");

        final name = parts.isNotEmpty ? parts[0] : '';
        final lastName =
            parts.length > 1 ? parts.sublist(1).join(" ") : 'Kadesh';

        final dio = Dio();
        final response = await dio.post(
          dotenv.env['API_LINK']!,
          data: {
            'query': AuthMutations.customLoginMutation,
            'variables': {
              'email': userData["email"],
              'name': name,
              'lastName': lastName,
            },
          },
        );
        final data = response.data['data']['customAuth']['data'];
        return KUser.fromJson(data);
      } else if (result.status == LoginStatus.cancelled) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}

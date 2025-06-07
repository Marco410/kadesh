import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return FirebaseOptions(
        appId: '1:224737492413:ios:64dc0e0057b2e212d766d4',
        apiKey: dotenv.env['FAPI_KEY_IOS']!,
        projectId: 'kadesh-a2d09',
        messagingSenderId: '224737492413',
        iosBundleId: 'com.kadesh.mc',
        authDomain: 'kadesh-a2d09.firebasestorage.app',
      );
    } else {
      // Android
      return FirebaseOptions(
        appId: '1:224737492413:android:376cfbe594dbe776d766d4',
        apiKey: dotenv.env['FAPI_KEY_G']!,
        projectId: 'kadesh-a2d09',
        messagingSenderId: '224737492413',
        authDomain: 'kadesh-a2d09.firebasestorage.app',
      );
    }
  }
}

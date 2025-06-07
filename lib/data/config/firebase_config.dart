import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:224737492413:ios:64dc0e0057b2e212d766d4',
        apiKey: 'AIzaSyD9eAreCp_tPXPzCY7QTNkvVsfOHXJ1vY8',
        projectId: 'kadesh-a2d09',
        messagingSenderId: '224737492413',
        iosBundleId: 'com.kadesh.mc',
        authDomain: 'kadesh-a2d09.firebasestorage.app',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:224737492413:android:376cfbe594dbe776d766d4',
        apiKey: 'AIzaSyAX_plqG28-fnLV_Tt7GJoBef88fSE9pto',
        projectId: 'kadesh-a2d09',
        messagingSenderId: '224737492413',
        authDomain: 'kadesh-a2d09.firebasestorage.app',
      );
    }
  }
}

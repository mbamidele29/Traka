// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBZTV_oJQLPTIQcCLI6NFd4vnq7Gj6TcYQ',
    appId: '1:781907781588:web:086ad22cf84608791e1841',
    messagingSenderId: '781907781588',
    projectId: 'traka-b796b',
    authDomain: 'traka-b796b.firebaseapp.com',
    storageBucket: 'traka-b796b.appspot.com',
    measurementId: 'G-WDZHXV9ZBB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdjwd16cADhfuytOtJosTBZbaukU-8KzM',
    appId: '1:781907781588:android:ca5c865b505d07001e1841',
    messagingSenderId: '781907781588',
    projectId: 'traka-b796b',
    storageBucket: 'traka-b796b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3mvDi9yPt56LBhHtExuQOTD3gtbBVspc',
    appId: '1:781907781588:ios:3f8a4054950995e41e1841',
    messagingSenderId: '781907781588',
    projectId: 'traka-b796b',
    storageBucket: 'traka-b796b.appspot.com',
    iosBundleId: 'com.movit.traka',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3mvDi9yPt56LBhHtExuQOTD3gtbBVspc',
    appId: '1:781907781588:ios:59feb72373d0bf1f1e1841',
    messagingSenderId: '781907781588',
    projectId: 'traka-b796b',
    storageBucket: 'traka-b796b.appspot.com',
    iosBundleId: 'com.movit.traka.RunnerTests',
  );
}

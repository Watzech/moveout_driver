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
    apiKey: 'AIzaSyB0qbIfFaGXgQHSnqjW10G1AgU5XvIyEUE',
    appId: '1:558449699615:web:cbe52d95f017a018331e2a',
    messagingSenderId: '558449699615',
    projectId: 'moveout-c74de',
    authDomain: 'moveout-c74de.firebaseapp.com',
    storageBucket: 'moveout-c74de.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXPRvqMoxTkzySieyYe1PSaAHy1s3fuyY',
    appId: '1:558449699615:android:ffb91e1a2b58c775331e2a',
    messagingSenderId: '558449699615',
    projectId: 'moveout-c74de',
    storageBucket: 'moveout-c74de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGGtGVwgSRME9A-Q6igqyVLnDxusIAZhg',
    appId: '1:558449699615:ios:afa47aa6250b6769331e2a',
    messagingSenderId: '558449699615',
    projectId: 'moveout-c74de',
    storageBucket: 'moveout-c74de.appspot.com',
    iosBundleId: 'com.moveout.driver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGGtGVwgSRME9A-Q6igqyVLnDxusIAZhg',
    appId: '1:558449699615:ios:370d102101b9e75c331e2a',
    messagingSenderId: '558449699615',
    projectId: 'moveout-c74de',
    storageBucket: 'moveout-c74de.appspot.com',
    iosBundleId: 'com.moveout.driver.RunnerTests',
  );
}

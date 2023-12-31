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
    apiKey: 'AIzaSyB4KMJGRy61S9RZKFKX3xndFFn5A4uTICk',
    appId: '1:502683862331:web:5323f0665ebc4cdf2a631e',
    messagingSenderId: '502683862331',
    projectId: 'summarease-65c84',
    authDomain: 'summarease-65c84.firebaseapp.com',
    storageBucket: 'summarease-65c84.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA042T0Vx30yqcsn99sxUdbw9IgArfoNeE',
    appId: '1:502683862331:android:237fed628ba59cb12a631e',
    messagingSenderId: '502683862331',
    projectId: 'summarease-65c84',
    storageBucket: 'summarease-65c84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhb0qdK0KoWf8Ho3At3nU5HtAHNXgCogI',
    appId: '1:502683862331:ios:547bd06668af5e812a631e',
    messagingSenderId: '502683862331',
    projectId: 'summarease-65c84',
    storageBucket: 'summarease-65c84.appspot.com',
    iosClientId: '502683862331-tbk2nrme6l41lmjunlihaa8p7bhbjgvl.apps.googleusercontent.com',
    iosBundleId: 'com.example.summarease',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhb0qdK0KoWf8Ho3At3nU5HtAHNXgCogI',
    appId: '1:502683862331:ios:7b3eb7f875642e882a631e',
    messagingSenderId: '502683862331',
    projectId: 'summarease-65c84',
    storageBucket: 'summarease-65c84.appspot.com',
    iosClientId: '502683862331-q33r11k0mpr4qand3bdnel9svgcpu0um.apps.googleusercontent.com',
    iosBundleId: 'com.example.summarease.RunnerTests',
  );
}
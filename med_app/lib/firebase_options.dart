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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDb9XoNbcmNOvx2ipFUW4rNeyxMpmtGnl8',
    appId: '1:191897147736:web:d1df1fc54a54bb1a406d2d',
    messagingSenderId: '191897147736',
    projectId: 'medappbase-b9ae2',
    authDomain: 'medappbase-b9ae2.firebaseapp.com',
    storageBucket: 'medappbase-b9ae2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWTLPUEVqqjCL7YQXQk5UveSQDTkcp9LE',
    appId: '1:191897147736:android:77b28b98c6975cd0406d2d',
    messagingSenderId: '191897147736',
    projectId: 'medappbase-b9ae2',
    storageBucket: 'medappbase-b9ae2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5KJIPS32bhAdKnqEou2TIwoA4xojJyVw',
    appId: '1:191897147736:ios:215087842773ffb4406d2d',
    messagingSenderId: '191897147736',
    projectId: 'medappbase-b9ae2',
    storageBucket: 'medappbase-b9ae2.appspot.com',
    iosClientId: '191897147736-37lsp8mm69068blbi65vqu9pb6llfp21.apps.googleusercontent.com',
    iosBundleId: 'com.example.medApp',
  );
}
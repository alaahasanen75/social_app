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
    apiKey: 'AIzaSyBZc2PNkvP9vO9AE9eXIphc438ZjnLGxyg',
    appId: '1:1036811337959:web:c0335a34c780219f12a242',
    messagingSenderId: '1036811337959',
    projectId: 'flutter-app-5b211',
    authDomain: 'flutter-app-5b211.firebaseapp.com',
    storageBucket: 'flutter-app-5b211.appspot.com',
    measurementId: 'G-19JXR0412Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7zC7DhI6g5r57NqpjwETdv_2PQall-So',
    appId: '1:1036811337959:android:70acbf0fa41fc34112a242',
    messagingSenderId: '1036811337959',
    projectId: 'flutter-app-5b211',
    storageBucket: 'flutter-app-5b211.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-vSrDu5wr0ogE3z9IoKJsh5Z1v5tOnaQ',
    appId: '1:1036811337959:ios:c50326a7ab998b2d12a242',
    messagingSenderId: '1036811337959',
    projectId: 'flutter-app-5b211',
    storageBucket: 'flutter-app-5b211.appspot.com',
    iosClientId: '1036811337959-u53gealqk9tmsb3s7qb20hko4ndah019.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-vSrDu5wr0ogE3z9IoKJsh5Z1v5tOnaQ',
    appId: '1:1036811337959:ios:c50326a7ab998b2d12a242',
    messagingSenderId: '1036811337959',
    projectId: 'flutter-app-5b211',
    storageBucket: 'flutter-app-5b211.appspot.com',
    iosClientId: '1036811337959-u53gealqk9tmsb3s7qb20hko4ndah019.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}

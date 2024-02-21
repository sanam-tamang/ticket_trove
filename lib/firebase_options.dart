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
    apiKey: 'AIzaSyAt811x3b7DOf0nq15CL1m2g_X_5j4SQW4',
    appId: '1:61701393404:web:0db68d2ea270d67fa38079',
    messagingSenderId: '61701393404',
    projectId: 'ticket-trove-52381',
    authDomain: 'ticket-trove-52381.firebaseapp.com',
    storageBucket: 'ticket-trove-52381.appspot.com',
    measurementId: 'G-SJ981MBEWD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0BtNiv-n_vRBMYfhp6LPYs_xU90zh5Jw',
    appId: '1:61701393404:android:4c2b8a5cc7902199a38079',
    messagingSenderId: '61701393404',
    projectId: 'ticket-trove-52381',
    storageBucket: 'ticket-trove-52381.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZmXbv5GK8Qsi9FpxI4rCBzvym6iSOKL4',
    appId: '1:61701393404:ios:0285b4b71b8cdde9a38079',
    messagingSenderId: '61701393404',
    projectId: 'ticket-trove-52381',
    storageBucket: 'ticket-trove-52381.appspot.com',
    iosClientId: '61701393404-492up5fm8enoqlln0g0j71gc6aia2d79.apps.googleusercontent.com',
    iosBundleId: 'com.mionovatech.myapp.ticketTrove',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZmXbv5GK8Qsi9FpxI4rCBzvym6iSOKL4',
    appId: '1:61701393404:ios:2245655ea1e9244ea38079',
    messagingSenderId: '61701393404',
    projectId: 'ticket-trove-52381',
    storageBucket: 'ticket-trove-52381.appspot.com',
    iosClientId: '61701393404-8h4rurj07vt2i9nk8neo17pnctvifi9i.apps.googleusercontent.com',
    iosBundleId: 'com.mionovatech.myapp.ticketTrove.RunnerTests',
  );
}

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
    apiKey: 'AIzaSyBGdBHXGeun1wC3gy8xq_vGXdbyMOPVl0c',
    appId: '1:921530642310:web:994132d602b04aa6794607',
    messagingSenderId: '921530642310',
    projectId: 'cli-firebase-7e997',
    authDomain: 'cli-firebase-7e997.firebaseapp.com',
    storageBucket: 'cli-firebase-7e997.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3yi0axZ6x10ccBjUw7Tsmr4SKPvKj7RA',
    appId: '1:921530642310:android:07326c3821c72b6b794607',
    messagingSenderId: '921530642310',
    projectId: 'cli-firebase-7e997',
    storageBucket: 'cli-firebase-7e997.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA96jMdKaQUdlCvbEaKQY2IVfcTPU42mQM',
    appId: '1:921530642310:ios:dc8362b1de192414794607',
    messagingSenderId: '921530642310',
    projectId: 'cli-firebase-7e997',
    storageBucket: 'cli-firebase-7e997.appspot.com',
    iosBundleId: 'com.firebase.targetCliConnect',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA96jMdKaQUdlCvbEaKQY2IVfcTPU42mQM',
    appId: '1:921530642310:ios:dc8362b1de192414794607',
    messagingSenderId: '921530642310',
    projectId: 'cli-firebase-7e997',
    storageBucket: 'cli-firebase-7e997.appspot.com',
    iosBundleId: 'com.firebase.targetCliConnect',
  );
}

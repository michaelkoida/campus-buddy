// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'PASTE_YOUR_WEB_API_KEY_HERE',
    appId: 'PASTE_YOUR_WEB_APP_ID_HERE',
    messagingSenderId: 'PASTE_YOUR_SENDER_ID_HERE',
    projectId: 'PASTE_YOUR_PROJECT_ID_HERE',
    authDomain: 'PASTE_YOUR_PROJECT_ID.firebaseapp.com',
    storageBucket: 'PASTE_YOUR_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'PASTE_YOUR_ANDROID_API_KEY_HERE',
    appId: 'PASTE_YOUR_ANDROID_APP_ID_HERE',
    messagingSenderId: 'PASTE_YOUR_SENDER_ID_HERE',
    projectId: 'PASTE_YOUR_PROJECT_ID_HERE',
    storageBucket: 'PASTE_YOUR_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'PASTE_YOUR_IOS_API_KEY_HERE',
    appId: 'PASTE_YOUR_IOS_APP_ID_HERE',
    messagingSenderId: 'PASTE_YOUR_SENDER_ID_HERE',
    projectId: 'PASTE_YOUR_PROJECT_ID_HERE',
    storageBucket: 'PASTE_YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.campusBuddyRcub',
  );
}
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyARq5ZnlCzVsItTlgm6tvFrZe85t3k6rzo',
      appId: '1:602149926420:android:4df28392e1d0b550479901',
      messagingSenderId: '602149926420',
      projectId: 'hi-tech-nursery',
      storageBucket: "hi-tech-nursery.appspot.com");

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRj3F3DaAYvi6SLA4h7JPiroQy4A9nKeM',
    appId: '1:602149926420:ios:a012ee7aeeb966f5479901',
    messagingSenderId: '602149926420',
    projectId: 'hi-tech-nursery',
    storageBucket: "hi-tech-nursery.appspot.com",
    iosBundleId: "com.example.onlinePlantsApp",
  );
}

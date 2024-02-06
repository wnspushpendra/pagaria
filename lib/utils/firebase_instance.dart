
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:webnsoft_solution/firebase_options.dart';

class FirebaseInstance {
  // firebase messaging object
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

 static  initializeFirebaseApp() async{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  }

  static Future<String?> getFcmToken() async{
    return await FirebaseMessaging.instance.getToken();
  }

  static notificationPermission() async{
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
  }



  }






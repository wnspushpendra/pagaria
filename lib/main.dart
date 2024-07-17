import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/intererror_dialog.dart';
import 'package:webnsoft_solution/app_common_widges/location.dart';
import 'package:webnsoft_solution/bloc_provider/bloc_providers.dart';
import 'package:webnsoft_solution/firebase_options.dart';
import 'package:webnsoft_solution/internet_cubit/internet_cubit.dart';
import 'package:webnsoft_solution/internet_cubit/internet_state.dart';
import 'package:webnsoft_solution/routes/custom_router.dart';
import 'package:webnsoft_solution/splash_screen.dart';
import 'package:webnsoft_solution/theme/app_theme.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/firebase_instance.dart';
import 'package:webnsoft_solution/utils/permisson_handler.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/*void downloadCallback(String id, int status, int progress) {
  if (status == DownloadTaskStatus.complete.index) {
    openDownloadedFile("", 'sample.pdf');

    print('Download task ($id) is complete.');
  }
}*/


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background message
  print("Handling a background message: ${message.messageId}");
}

initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
 // await FlutterDownloader.initialize();
  handlePermissions().then((value) {});
  checkLocationPermission();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseInstance.notificationPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) =>  print("Foreground Message Received: $message"));
  await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();


  // Initialize Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Handle incoming messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message Received: $message");
  });
  setStringPref(firebaseTokenPrefecences, await FirebaseInstance.getFcmToken()??'');
}

void main() async {
  initializeDependencies();
  runApp(MyApp(await checkConnection()));
}

class MyApp extends StatefulWidget {
  final bool connection;

  const MyApp(this.connection, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return BlocProvider(
          create: (context) => InternetCubit(),
          child: MultiBlocProvider(
            providers: getProvider,
            child: Builder(
              builder: (context) {
                return BlocBuilder<InternetCubit, InternetState>(
                    builder: (context, state) {
                      if (state == InternetState.connected) {
                        return ScreenUtilInit(
                          designSize: const Size(375, 812),
                          builder: (BuildContext context, child) => MaterialApp(
                            title: 'Flutter Demo',
                            debugShowCheckedModeBanner: false,
                            theme: appTheme,
                            home:  const SplashScreen(),
                            onGenerateRoute: CustomRouter.generateRoute,
                          ),
                        );
                      } else {
                        return MaterialApp(
                          theme: ThemeData(primaryColor: Colors.white),
                          home: const NetworkErrorDialog(),
                        );
                      }
                    }
                );
              },
            ),
          ),
        );
      },
    );
  }
}

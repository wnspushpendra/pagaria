import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/intererror_dialog.dart';
import 'package:webnsoft_solution/app_common_widges/location.dart';
import 'package:webnsoft_solution/bloc_provider/bloc_providers.dart';
import 'package:webnsoft_solution/internet_cubit/internet_cubit.dart';
import 'package:webnsoft_solution/internet_cubit/internet_state.dart';
import 'package:webnsoft_solution/routes/custom_router.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/splash_screen.dart';
import 'package:webnsoft_solution/theme/app_theme.dart';
import 'package:webnsoft_solution/utils/permisson_handler.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  handleStoragePermission().then((value) {});
  checkLocationPermission();
  await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

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
            child: BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                  return MaterialApp(
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    theme: appTheme,
                    home: state == InternetState.initial || state == InternetState.connected ? const SplashScreen() :  const NetworkErrorDialog()  ,
                    onGenerateRoute: CustomRouter.generateRoute,
                  );
                  },
            ),
          ),
        );
      },
    );
  }
}

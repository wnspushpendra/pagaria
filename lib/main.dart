import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_detail.dart';
import 'package:webnsoft_solution/bloc_provider/bloc_providers.dart';
import 'package:webnsoft_solution/routes/custom_router.dart';
import 'package:webnsoft_solution/splash_screen.dart';
import 'package:webnsoft_solution/theme/app_theme.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/permisson_handler.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  handleStoragePermission().then((value) {
    print(value);
  }
);
  await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return MultiBlocProvider(
          providers: getProvider,
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: const SplashScreen(),
            onGenerateRoute: CustomRouter.generateRoute,
          ),
        );
      },
    );
  }
}

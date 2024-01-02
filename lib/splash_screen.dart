import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({ Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    splashNextProcess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: Image.asset('assets/pagaria_logo.gif'),
      ),
    );
  }

  void splashNextProcess() {
    Future.delayed(
        const Duration(seconds: 3),
            () => checkLoginActions(),
        );
  }


  checkLoginActions() async {
    bool? login = await getBoolPref(userLoginPrefecences);
    if(login != null && login == true){
      Future.delayed( const Duration(seconds: 0),(){Navigator.pushNamed(context, navigationRoute);});
    }else{
      Future.delayed(const Duration(seconds: 0),(){
        onPopReplace(context, loginRoute);
      });
    }
  }
}

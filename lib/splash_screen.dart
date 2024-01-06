import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_ui/auth/login/login.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({ Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  bool selected = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
  // changeAnimatedState();
    //splashNextProcess();
    super.initState();
  }
  changeAnimatedState(){
    Future.delayed(const Duration(seconds: 8),(){
      setState(() {
        selected = !selected;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
   /* const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );*/

    return AnimatedSplashScreen.withScreenFunction(
      splash: logo,
      screenFunction: () async{
        return checkLoginActions(context);
      },
      splashTransition: SplashTransition.rotationTransition,
     // pageTransitionType: PageTransitionType.scale,
    );
    return Scaffold(
      backgroundColor: bodyWhite,
      body: Center(
        child:
       /* SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 60.0,
              fontFamily: 'Canterbury',
              fontWeight: FontWeight.bold,
              color: bodyWhite
            ),
            child: AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: const Duration(seconds: 2000),
              animatedTexts: [
            ColorizeAnimatedText(
                  'PAGARIA',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              onTap: () {
              },
            ),
          ),
        )*/
         ScaleTransition(
          scale: _animation,
          child:  Padding(
            padding: EdgeInsets.all(8.h),
            child: Image.asset(logo,height: 80.h,),
          ),
        ),
      ),

     /* Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AnimatedAlign(
            alignment: selected ? Alignment.center : Alignment.topLeft,
            duration: const Duration(seconds: 3),
            curve: Curves.easeInOutBack,
            child:  Image.asset(splashImage,height: 100.h,),
          ),
        ),
      ),*/
    );
  }

  Future<Widget> checkLoginActions(BuildContext context) async {
    bool? login = await getBoolPref(userLoginPrefecences);

    await Future.delayed(const Duration(seconds: 1), () async{
      if (login != null && login == true) {
        User? user = await getUserPref(userProfileDataPrefecences);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
        });
      } else {
        Navigator.pushReplacementNamed(context, loginRoute);
      }
    });

    // Returning a dummy widget as the Future<Widget> completion
    return Container(); // You can replace Container() with any widget you desire.
  }

}





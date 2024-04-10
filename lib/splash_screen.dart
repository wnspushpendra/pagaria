
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
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


    return AnimatedSplashScreen.withScreenFunction(
      splash: logo,
      screenFunction: () async{
        return checkLoginActions(context);
      },
      splashTransition: SplashTransition.rotationTransition,
    );
  }

  Future<Widget> checkLoginActions(BuildContext context) async {
    bool? login = await getBoolPref(userLoginPrefecences);
    await Future.delayed(const Duration(seconds: 1), () {
      if (login == true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          User user = await getUser();
          if(user.roleId == '4'){
           WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
             ChangeRoutes.openHomeScreen(context, user);
           });
          }else{
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ChangeRoutes.openHomeScreen(context, user);
            });
          }
        });
      } else {
        Navigator.pushReplacementNamed(context, loginRoute);
      }
    });
    return Container(); // You can replace Container() with any widget you desire.
  }
}





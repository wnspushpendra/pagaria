import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/nav_drawer/drawer_item.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/dialogs.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class MyDrawer extends StatelessWidget {
  final User user;
  const MyDrawer({required this.user,super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: bodyWhite,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Space(height: 16,),
                  /**** navigation header page *********/
                  headerWidget(context, user),
                  Container(
                    color: primaryColor,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.fromLTRB(8, 20, 10, 0),
                    child: Column(
                      children: [
                        /**** moving to home page *********/
                        DrawerItem(
                            name: home,
                            icon: homeIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, homeRoute,arguments:  [await getUser(),await checkConnection()]);
                            }),
                        const Space(height: 10,),
                        /**** moving to user profile page *********/
                        DrawerItem(
                            name: profile,
                            icon: profileIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, profileRoute,arguments: await getUser());
                            }),
                        const Space(height: 10,),
                        /**** moving to product page *********/
                        DrawerItem(
                            name: product,
                            icon:productIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, productRoute,arguments: 'home');
                            }),
                        const Space(height: 10,),
                        /**** moving to customer page *********/
                        DrawerItem(
                            name: customer,
                            icon: customerIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, customerRoute);
                            }),
                        const Space(height: 10,),
                        /**** moving to order list page *********/
                        DrawerItem(
                            name: orderList,
                            icon: orderIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, orderRoute,arguments: true);
                            }),
                        const Space(height: 10,),
                        /**** moving to payment  page *********/
                        DrawerItem(
                            name: payment,
                            icon: paymentIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, paymentRoute);
                            }),
                        const Space(height: 10,),
                        /**** moving to reset password page *********/
                        DrawerItem(
                            name: resetPassword,
                            icon: resetPasswordIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, resetPasswordRoute,arguments: await getUser());
                            }),
                        const Space(height: 10,),
                        /**** logout user *********/
                        DrawerItem(
                            name: logout,
                            icon: logoutIcon,
                            onPressed: () => logoutDialog(context)),
                        const Space(height: 10,),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context, User user,) {
    return Container(
      height: 147.h,
      color: bodyWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space(height: 20,),
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Container(
                  height: 80.h,
                  color: Colors.white,
                  child: Image.asset(logo),
                ),
              ),
            ],
          ),
           SizedBox(
            height: 20.h,
          ),
          Padding(
           padding: EdgeInsets.symmetric(horizontal: 8.h),
           child:  BodyText(text: user.fullName.toString(),color: primaryColor,),
         ),
          const Space(height: 3,),

        ],
      ),
    );
  }

/*  getImage() async {
    image = await getStringPref(Constant.userImagePref);
    name = await getStringPref(Constant.userNamePref);
  }*/
}

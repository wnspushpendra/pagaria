import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/left_navbar/drawer_item.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/dialogs.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Space(height: 16,),
                  headerWidget(context, ''),
                  Container(
                    color: primaryColor,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.fromLTRB(8, 20, 10, 0),
                    child: Column(
                      children: [
                        DrawerItem(
                            name: home,
                            icon: homeIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              onPopReplace(context, navigationRoute);
                            }),
                        const Space(height: 10,),
                        DrawerItem(
                            name: profile,
                            icon: profileIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              onPopReplace(context, profileRoute);
                            }),
                        const Space(height: 10,),
                        DrawerItem(
                            name: product,
                            icon:productIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              onPopReplace(context, productRoute);
                            }),
                        const Space(height: 10,),
                        DrawerItem(
                            name: customer,
                            icon: orderIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              onPopReplace(context, customerRoute);
                            }),
                        const Space(height: 10,),
                        DrawerItem(
                            name: order,
                            icon: customerIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              onPopReplace(context, orderRoute);
                            }),
                        const Space(height: 10,),
                        DrawerItem(
                            name: payment,
                            icon: paymentIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              onPopReplace(context, paymentRoute);
                            }),
                        const Space(height: 10,),
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

  Widget headerWidget(BuildContext context, String name) {
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
           child: const BodyText(text: 'User Name',color: primaryColor,),
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

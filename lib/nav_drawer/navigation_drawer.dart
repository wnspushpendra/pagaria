import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/nav_drawer/drawer_item.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
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
                  userHeader(context, user),
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
                              ChangeRoutes.openHomeScreen(context, user);
                           //   Navigator.pushReplacementNamed(context,user.roleId =='4' ? homeRoute : homeDistributorRoute,arguments:  await getUser());
                            }),
                        /**** moving to user profile page *********/
                        DrawerItem(
                            name: profile,
                            icon: profileIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openProfileScreen(context, user);
                            }),
                        /**** moving to My Activity page *********/
                        user.roleId == '4' ?    DrawerItem(
                            name:'My Activity' ,
                            icon: myActivityIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openMyActivityScreen(context);
                            }) : Container(),
                        /**** moving to My Shop Visit  page *********/
                        user.roleId == '4' ?    DrawerItem(
                            name:'My Shop Visit' ,
                            icon: visitIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openMyVisitScreen(context);
                            }) : Container(),
                        /**** moving to user profile page *********/
                        user.roleId == '5' ?    DrawerItem(
                            name:'My Ledger' ,
                            icon: downloadLedger,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openLedgerScreen(context,await ChangeRoutes.getUserId(),true);
                            }) : Container(),
                        /**** moving to product page *********/
                        DrawerItem(
                            name: product,
                            icon:productIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openProductScreen(context, user,null);
                            }),
                        /**** moving to customer page *********/
                     user.roleId == '4' ?    DrawerItem(
                            name: customer,
                            icon: customerIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, customerListRoute);
                            }) : Container(),
                        /**** moving to order list page *********/
                        DrawerItem(
                            name: orders,
                            icon: orderIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openOrderScreen(context, true);
                           //   Navigator.pushReplacementNamed(context, orderRoute,arguments: true);
                            }),
                        /**** moving to payment  page *********/
                        DrawerItem(
                            name: payment,
                            icon: paymentIcon,
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                              ChangeRoutes.openExecutivePaymentScreen(context, user);
                             // Navigator.pushReplacementNamed(context, paymentRoute);
                            }),
                        /**** moving to reset password page *********/
                        DrawerItem(
                            name: resetPassword,
                            icon: resetPasswordIcon,
                            onPressed: () async{
                              Scaffold.of(context).closeDrawer();
                              Navigator.pushReplacementNamed(context, resetPasswordRoute,arguments: await getUser());
                            }),
                        /**** logout user *********/
                        DrawerItem(
                            name: logout,
                            icon: logoutIcon,
                            onPressed: () => logoutDialog(context)),
                        const Space(height: 4,),
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

  Widget userHeader(BuildContext context, User user,) {
    return Container(
    color: bodyWhite,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(horizontal: 12.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space(height: 15.h,),
        ClipRRect(
          borderRadius: BorderRadius.circular(40.h),
          child: user.profileImageUrl != null && user.profileImageUrl.toString() != 'https://pagaria.wecoderelationship.com' ?
          CachedNetworkImage(
            imageUrl: user.profileImageUrl!,
            fit: BoxFit.fill, width: 80.h,height: 80.h,
          )
              : Image.asset(profileDefaultImage, width: 80.h,height: 80.h,),
        ),
        Space(height: 8.h,),
        BodyText(text: user.fullName??'',fontWeight: FontWeight.bold,),
        BodyText(text: user.email??'',fontWeight: FontWeight.bold,),
        Space(height: 8.h,),


      ],
    ),
    );
    return Container(
      height: 150.h,
      color: bodyWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Space(height: 20,),
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Container(
                  height: 75.h,
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
/*  Widget userHeader(BuildContext context,) {
    return Container(
      color: bodyWhite,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space(height: 15.h,),
          ClipRRect(
            borderRadius: BorderRadius.circular(40.h),
            child: widget.user!.profileImageUrl != null && widget.user!.profileImageUrl.toString() != 'https://pagaria.wecoderelationship.com' ?
            CachedNetworkImage(
              imageUrl: widget.user!.profileImageUrl!,
              fit: BoxFit.fill, width: 80.h,height: 80.h,
            )
                : Image.asset(AssetImages.profileDefaultImage, width: 80.h,height: 80.h,),
          ),
          Space(height: 8.h,),
          BodyText(text: widget.user!.fullName??'',fontWeight: FontWeight.bold,),
          BodyText(text: widget.user!.email??'',fontWeight: FontWeight.bold,),
          Space(height: 8.h,),


        ],
      ),
    );
  }*/


}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/target_screen.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_list/order_list_widget.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/nav_drawer/navigation_drawer.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/dialogs.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({required this.user,super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      key: _key,
      drawer:  MyDrawer(user : widget.user),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            if (_key.currentState != null) {
              _key.currentState!.openDrawer();
            }
          },
          icon: const Icon(Icons.menu,color: bodyWhite,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(logo,height: 26,),
            const Space(width: 8,),
            const BodyText(
              text: home,
              color: bodyWhite,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => logoutDialog(context),
              icon: const Icon(
                Icons.logout_rounded,
                color: bodyWhite,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPopReplace(context, addCustomerRoute),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: defaultDecoration,
            margin: EdgeInsets.all(8.h),
            padding: EdgeInsets.all(10.h),
            child: const TargetScreen()
          ),
          if (deviceWidth > 1200)
            showCustomerPayment(3),
          if (deviceWidth > 600)
            showCustomerPayment(2),
          if (deviceWidth > 300)
            showCustomerPayment(1)
        ],
      ),
    );
  }

  Widget showCustomerPayment(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.all(8),
              child: BodyText(text: 'Recent Payment',color: bodyBlack,fontWeight: FontWeight.bold,)),
          GridView.builder(
              gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  mainAxisExtent: 140.h
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const OrderListWidget();
              }),
           Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BodyText(text: 'Recent Customer',color: bodyBlack,fontWeight: FontWeight.bold,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, customerRoute,);                  },
                      child: const BodyText(text: 'View All',fontSize : 12,color: primaryColor,)),
                ],
              )),
          GridView.builder(
              gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  mainAxisExtent: 190.h
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomerListItem(
                  name: 'Yuvraj Singh',
                  contactNumber: '0123456789',
                  emailAddress: 'yuvi@gmail.com',
                  add: '54 vijay nagar indore',
                  onPressed: () => onPopReplace(context, createOrderRoute),);
              }),



        ],
      ),
    );
  }


}

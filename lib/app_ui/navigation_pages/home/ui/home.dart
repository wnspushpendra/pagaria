import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/target_screen.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/target_widget.dart';
import 'package:webnsoft_solution/left_navbar/navigation_drawer.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/dialogs.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
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
        title: const BodyText(
          text: home,
          color: bodyWhite,
          fontWeight: FontWeight.bold,
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
            shoList(3),
          if (deviceWidth > 600)
            shoList(2),
          if (deviceWidth > 300)
            shoList(1)
        ],
      ),
    );
  }


  Widget shoList(int i) {
    return GridView.builder(
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisExtent: 190.h
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomerListItem(
            name: 'Yuvraj Singh',
            contactNumber: '0123456789',
            emailAddress: 'yuvi@gmail.com',
            add: '54 vijay nagar indore',
            onPressed: () => onPopReplace(context, createOrderRoute),);
        });
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerScreen extends StatefulWidget {

  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Customer',   () async{
        User? user = await getUserPref(userProfileDataPrefecences);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
        });
      }),
      floatingActionButton:  FloatingActionButton.extended(
          onPressed: () => onPopReplace(context, addCustomerRoute),
          label: const BodyText(text: 'Add Customer',color: bodyWhite,)),
      body: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 70),
        child: GridView.builder(
            gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                mainAxisExtent: 190.h
            ),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return  CustomerListItem(name: 'Yuvraj Singh', contactNumber: '0123456789', emailAddress: 'yuvi@gmail.com', add: '54 vijay nagar', onPressed: (){},);
            })


    /*    ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context,state){
              return  CustomerListItem(customerName: 'Yuvraj Singh', contactNumber: '0123456789', emailAddress: 'yuvi@gmail.com', address: '54 vijay nagar indore', onPressed: (){},);
            }),*/
      ),
    );
  }
}

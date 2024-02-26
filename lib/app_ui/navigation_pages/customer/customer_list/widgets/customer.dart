import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerListScreen extends StatefulWidget {

  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        ChangeRoutes.openHomeScreen(context, await getUser());
        return true;
      },
      child: Scaffold(
        appBar: appBarWidget(context, 'Customer',   () async{
          Navigator.pushReplacementNamed(context, homeRoute,arguments:await getUser());
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushReplacementNamed(context, addCustomerRoute),
          child: const Icon(Icons.add),
        ),

        body: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: const CustomerList(),

        ),
      ),
    );
  }
}

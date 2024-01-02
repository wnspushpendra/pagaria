import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/customer_basic_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/ledget_book.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerDetailScreen extends StatefulWidget {
  final int index;
  const CustomerDetailScreen( {required this.index,super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.index??1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,color: bodyWhite,),
            onPressed: ()=> onPopReplace(context, homeRoute),
          ),
          title: const NormalText(text: 'Customer Detail',),
          bottom:   const TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelStyle: TextStyle(color: bodyWhite),
              padding: EdgeInsets.symmetric(vertical: 8),
              tabs: [
                Tab(child: BodyText(text: 'Basic Detail',color: bodyWhite,fontWeight: FontWeight.bold,),),
                Tab(child: BodyText(text: 'Order History',color: bodyWhite,fontWeight: FontWeight.bold,),),
                Tab(child: BodyText(text: 'Payment',color: bodyWhite,fontWeight: FontWeight.bold,),),
                Tab(child: BodyText(text: 'Ledger Book',color: bodyWhite,fontWeight: FontWeight.bold,),),
              ]),
        ),
        body:  const TabBarView(
            children:[
              CustomerBasicDetails(),
              OrderScreen(),
              PaymentScreen(),
              LedgetBookScreen(),
            ] ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/customer_basic_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/ledget_book.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_payment/customer_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/ledger.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_list/order.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/customer_detail.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerDetailScreen extends StatefulWidget {
  final CustomerDetailModal customerDetailModal;

  const CustomerDetailScreen({ required this.customerDetailModal,super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => ChangeRoutes.openCustomerScreen(context, null),

      child: DefaultTabController(
        length: 4,
        initialIndex:widget.customerDetailModal.index ?? 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,color: bodyWhite,),
              onPressed: () async=> Navigator.pushReplacementNamed(context, homeRoute,arguments:  await getUser()),
            ),
            title: const BodyText(text: 'Customer Summary',color: bodyWhite,),
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
          body:   WillPopScope(
              onWillPop: () async {
                ChangeRoutes.openCustomerScreen(context, null);
                return true;
              },  child: TabBarView(
                children:[
                  CustomerBasicDetails(customer : widget.customerDetailModal.customerDetails!),
                   OrderScreen(distributorId: widget.customerDetailModal.customerDetails!.id.toString(),fromMenu: false,),
                   CustomerPaymentScreen(customer : widget.customerDetailModal.customerDetails!),
                  LedgerScreen(argument:LedgerArgument(distributorId: widget.customerDetailModal.customerDetails!.id.toString(),showAppbar: false)),
                ] ),
          ),
        ),
      ),
    );
  }
}

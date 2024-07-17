import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/tabs/payment_widget.dart';
import 'package:webnsoft_solution/modal/argument_modal/DistributorHomeArgument.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor/distributor_order_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class DistributorPayments extends StatefulWidget {
  final DistributorHomeArgument argument;
  const DistributorPayments( {required this.argument, super.key});

  @override
  State<DistributorPayments> createState() => _DistibutorPaymentsState();
}

class _DistibutorPaymentsState extends State<DistributorPayments> {
  String paymentType = 'Pending Payment';
  ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

@override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    if(widget.argument.status == 'completed'){
       paymentType = 'Completed Payment';
    }else if(widget.argument.status == 'recent'){
       paymentType = 'Recent Payment';

    }else{
       paymentType = 'Pending Payment';
    }
    setState(() {});

}


  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) { // Adding a buffer
      setState(() {
        _isAtBottom = true;
      });
    } else {
      setState(() {
        _isAtBottom = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.argument.orderList.isEmpty ?
          Center(child: BodyText(text: 'No item for ${widget.argument.status} order',color: primaryColor,),)
     : Stack(
       children: [
         ListView.builder(
             controller: _scrollController,
             itemCount: widget.argument.orderList.length,
              itemBuilder: (context,index){
                DistributorPayment order = widget.argument.orderList[index];
            return  DistributorPaymentWidget(paymentStatus:paymentType,order: order);
          }),
       /*  if (!_isAtBottom)
           Positioned(
             bottom: 0,
             left: 10,
             child: CustomButton(
               buttonText: 'Order',
               buttonWidth: 140,
               radius: 30,
               onClick: () async => ChangeRoutes.openProductScreen(context, await getUser(),null),
             ),
           ),*/
       ],
     ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/tabs/payment_widget.dart';
import 'package:webnsoft_solution/modal/argument_modal/DistributorHomeArgument.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor/distributor_order_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class DistributorPayments extends StatefulWidget {
  final DistributorHomeArgument argument;
  const DistributorPayments( {required this.argument, super.key});

  @override
  State<DistributorPayments> createState() => _DistibutorPaymentsState();
}

class _DistibutorPaymentsState extends State<DistributorPayments> {
  String paymentType = 'Pending Payment';

@override
  void initState() {
    super.initState();
    if(widget.argument.status == 'completed'){
       paymentType = 'Completed Payment';
    }else if(widget.argument.status == 'recent'){
       paymentType = 'Recent Payment';

    }else{
       paymentType = 'Pending Payment';
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.argument.orderList.isEmpty ?
          Center(child: BodyText(text: 'No item for ${widget.argument.status} order',color: primaryColor,),)
     : ListView.builder(
        itemCount: widget.argument.orderList.length,
          itemBuilder: (context,index){
            DistributorPayment order = widget.argument.orderList[index];
        return  DistributorPaymentWidget(paymentStatus:paymentType,order: order);
      }),
    );
  }
}

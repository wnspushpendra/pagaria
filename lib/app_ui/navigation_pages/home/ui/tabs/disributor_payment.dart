import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/tabs/payment_widget.dart';

class DistributorPayments extends StatefulWidget {
 final String paymentStatus;
  const DistributorPayments( {required this.paymentStatus, super.key});

  @override
  State<DistributorPayments> createState() => _DistibutorPaymentsState();
}

class _DistibutorPaymentsState extends State<DistributorPayments> {
  String paymentType = 'Pending Payment';

@override
  void initState() {
    super.initState();
    if(widget.paymentStatus == 'completed'){
       paymentType = 'Completed Payment';
    }else if(widget.paymentStatus == 'recent'){
       paymentType = 'Recent Payment';

    }else{
       paymentType = 'Pending Payment';
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context,state){
        return  DistributorPaymentWidget(paymentStatus:paymentType,);
      }),
    );
  }
}

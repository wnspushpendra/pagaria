import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/connecivity_bloc/api_status_string.dart';

class OrderPaymentStatus extends StatelessWidget {
  final String status;
  const OrderPaymentStatus({required this.status,super.key});

  @override
  Widget build(BuildContext context) {
    String orderStatus = status == ApiString.pendingOrder ?
    'Pending' : status == ApiString.approvedOrder ? 'Approved' : status == ApiString.rejectOrder ? 'Rejected'
    : status == ApiString.completedOrder ?'Completed' : status == ApiString.deliveredOrder ? 'Delivered' :
    status == ApiString.partialPaymentPayment ? 'Partial Payment' :
    'Pending';
    Color color =  status == ApiString.approvedOrder ? Colors.lightGreen : status == ApiString.rejectOrder ? primaryColor
        : status == ApiString.completedOrder ? Colors.green : status == ApiString.deliveredOrder ? Colors.green :
    status == ApiString.partialPaymentPayment ? Colors.deepOrange :  status == ApiString.halfPayment ? Colors.orange:
    bodyLightBlack;
    return  BodyText(
      text: orderStatus ,
      color: color,
      fontSize: 14.h,
    );
  }
}

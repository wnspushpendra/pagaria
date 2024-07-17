import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentDetailData paymentDetail;
  const PaymentWidget({required this.paymentDetail,super.key});

  @override
  Widget build(BuildContext context) {
    return  paymentDetail.amount == null ? const SizedBox.shrink() :
      Container(
      padding:  EdgeInsets.all(12.h),
      margin:  EdgeInsets.fromLTRB(2.h, 5.h, 2.h, 5.h),
      decoration: defaultDecoration,
      child:  Column(
        children: [
          Row(
              children: [
                Expanded(
                  flex : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: customerName,fontSize: 16.h,),
                       BodyText(text: paymentDetail.userData!.fullName??'',color: primaryColor,),
                    ],
                  ),
                ),
                Expanded(
                  flex : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: email,fontSize: 16.h,),
                       NormalText(text: paymentDetail.userData!.email??'',color: primaryColor,),
                    ],
                  ),
                )
              ]),
          Space(height: 8.h,),
           Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BodyText(text: 'Payment Type',),
                      BodyText(text: paymentDetail.paymentType??'-',color: primaryColor,),
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const BodyText(text: 'Paid Amount',),
                      BodyText(text: '$rupeesSymbol${paymentDetail.amount != null ?paymentDetail.amount.toString() : "0"}',color: primaryColor,),
                    ],
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}

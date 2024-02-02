import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      BodyText(text: 'Customer Name',fontSize: 16.h,),
                      const BodyText(text: 'Yuvraj Singh',color: primaryColor,),
                    ],
                  ),
                ),
                Expanded(
                  flex : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: mobileNumber,fontSize: 16.h,),
                      const BodyText(text: '0123456779',color: primaryColor,),
                    ],
                  ),
                )
              ]),
          Space(height: 8.h,),
          const Row(
              children: [
                 Expanded(
                   flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: 'Item',),
                      BodyText(text: '5',color: primaryColor,),
                    ],
                  ),
                ),
                 Expanded(
                   flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: 'Total Price',),
                      BodyText(text: '500000',color: primaryColor,),
                    ],
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}

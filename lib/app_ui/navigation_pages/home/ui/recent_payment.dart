import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_list/order_list_widget.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class RecentPayment extends StatelessWidget {
  const RecentPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const BodyText(text: 'View All',fontSize: 12,color: bodyBlack,),
          Expanded(
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 500,
                    mainAxisExtent: 140.h
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const OrderListWidget();
                }),
          ),
        ],
      ),
    );
  }
}

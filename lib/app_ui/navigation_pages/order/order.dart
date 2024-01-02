import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';



class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   appBar: appBarWidget(context, 'Order ', ()=>onPopReplace(context, homeRoute)),
      body: Container(
        padding:  EdgeInsets.all(12.h),
        child: ListView.builder(
          itemCount: 10, itemBuilder: (context,state){
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
                 Row(
                    children: [
                      const Expanded(
                        flex : 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(text: 'Total Price',),
                            BodyText(text: '500000',color: primaryColor,),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomButton(buttonText: 'Detail',buttonTextSize: 12,
                            buttonWidth : 96,buttonHeight: 30,padding: 0,
                            radius: 15,
                            onClick: ()=> onPopReplace(context, orderDetailRoute)),
                      )
                    ]),
              ],
            ),
          );
        }),
      ),
    );
  }
}

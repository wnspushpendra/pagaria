import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/customer_detail.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class DistributorPaymentWidget extends StatelessWidget {
  final String paymentStatus;
  final Customer? customerDetails;

  const DistributorPaymentWidget(
      {required this.paymentStatus,
        this.customerDetails,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all(8),
      margin: EdgeInsets.all(4.h),
      alignment: Alignment.center,
      decoration: defaultDecoration,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     BodyText(
                      text: customerName,fontSize: 16,color: primaryColor,
                    ),
                    BodyText(
                      text: 'me customer'/*customerDetails.fullName.toString()*/,
                      color: bodyBlack,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BodyText(text: paymentStatus,fontSize: 16,color: primaryColor,),
                      NormalText(text: '$rupeesSymbol 5000'/*ustomerDetails.email.toString()*/, color: bodyBlack,),
                    ],
                  )),
            ],
          ),
           Space(height: 6,),
           Row(
            children: [
              Expanded(
                flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       BodyText(text: mobileNumber,fontSize: 16,color: primaryColor,align: TextAlign.start,),
                      BodyText(
                        text:'123344545' /*customerDetails.contactNo.toString()*/,
                        color: bodyBlack,
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       BodyText(text: email,fontSize: 16,color: primaryColor,),
                      NormalText(text: 'me customre@gmail.com'/*ustomerDetails.email.toString()*/, color: bodyBlack,),
                    ],
                  )),
            ],
          ),
           Space(height:6 ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      BodyText(text:address,fontSize: 16,color: primaryColor,),
                     NormalText(text: '9/3 vijay nagar indore'/*"${customerDetails.address},${customerDetails.city},${customerDetails.state},${customerDetails.zipCode}"*/,color: bodyBlack,),
                  ],
                ),
              ),
              Space(width: 4,),
              /*Container(
                width: 140,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CustomButton(
                    buttonText: 'Ledger',
                    buttonTextSize: 11,
                    buttonTextColor: bodyWhite,
                    margin: 0,
                    radius: 18,
                    buttonWidth: 110,
                    buttonHeight: 36,
                    image: downloadLedger,
                    onClick: () {}),
              )*/
            ],
          ),
        ],
      ),
    );
  }

}

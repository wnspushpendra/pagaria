import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/customer_detail.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor/distributor_order_modal.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class DistributorPaymentWidget extends StatelessWidget {
  final String paymentStatus;
  final DistributorPayment order;

  const DistributorPaymentWidget({required this.paymentStatus,required this.order,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all(8),
      margin: EdgeInsets.all(4.h),
      alignment: Alignment.center,
      decoration: defaultDecoration,
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(text: 'Payment ID',fontSize: 16,color: primaryColor,),
                    NormalText(text: '${order.id.toString()} ', color: bodyBlack,),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(text: 'Order ID',fontSize: 16,color: primaryColor,),
                    BodyText(text: order.orderDetails!.id.toString(), ),
                  ],
                ),
              ),
            ],
          ),*/
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     const BodyText(text: name,fontSize: 16,color: primaryColor,),
                    BodyText(
                      text: order.executiveData != null ? order.executiveData!.fullName! : order.userData!.fullName.toString() ,
                      color: bodyBlack,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       BodyText(text: mobileNumber,fontSize: 12.h,color: primaryColor,align: TextAlign.start,),
                      BodyText(text: order.executiveData != null ? order.executiveData!.contactNo.toString() : order.userData!.contactNo.toString() , color: bodyBlack,fontSize: 14.h,),
                    ],
                  )),

            ],
          ),
           Row(
            children: [
               Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       BodyText(text: 'Total Amount',fontSize: 12.h,color:  primaryColor,),
                      NormalText(text: '${order.orderDetails!.totalAmount.toString()} ', color: bodyBlack,textSize: 14.h,),
                    ],
                  )),
              paymentStatus == 'Pending Payment'?
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       BodyText(text: 'Remaining  Amount',fontSize: 12.h,color: primaryColor,),
                       NormalText(text: '$rupeesSymbol ${order.dueAmount.toString()}', color: Colors.green,textSize: 14.h,),
                    ],
                  )) :
              paymentStatus == 'Recent Payment'?
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       BodyText(text: 'Paid Amount',fontSize: 12.h,color: primaryColor,),
                      NormalText(text: '$rupeesSymbol ${order.amount.toString()}', color: Colors.green,textSize: 14.h),
                    ],
                  ))  :
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       BodyText(text: 'Date',fontSize: 12.h,color: primaryColor,),
                      NormalText(text: getDDMMYYYYDateStringDate(order.date!), color: bodyBlack,textSize: 14.h,),
                    ],
                  ))],
          ),
            Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                const BodyText(text: email,fontSize: 16,color: primaryColor,),
               BodyText(text: order.executiveData != null ? order.executiveData!.email.toString() : order.userData!.email.toString() , color: bodyBlack,),
             ],
           ),
           const Space(height:6 ,),
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const BodyText(text:address,fontSize: 16,color: primaryColor,),
                     NormalText(text: order.shippingAddress??''*//*"${customerDetails.address},${customerDetails.city},${customerDetails.state},${customerDetails.zipCode}"*//*,color: bodyBlack,),
                  ],
                ),
              ),
              *//*Container(
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
              )*//*
            ],
          ),*/
        ],
      ),
    );
  }

}

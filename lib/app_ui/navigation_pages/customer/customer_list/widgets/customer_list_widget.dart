import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class CustomerListItem extends StatelessWidget {
  final String name;
  final String contactNumber;
  final String emailAddress;
  final String add;
  final Function onPressed;

  const CustomerListItem(
      {required this.name,
      required this.contactNumber,
      required this.emailAddress,
      required this.add,
        required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all(8),
      margin: EdgeInsets.all(4.h),
      alignment: Alignment.center,
      decoration: defaultDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     const BodyText(
                      text: customerName,fontSize: 16,color: primaryColor,
                    ),
                    BodyText(
                      text: name,
                      color: bodyBlack,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  AssetButton(image: visibility, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: 0)),
                  AssetButton(image: createOrder, onPressed: () => Navigator.pushReplacementNamed(context, createOrderRoute,)),
                  AssetButton(image: paymentIcon, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: 2)),
                  AssetButton(image: history, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: 1)),
                ],
              ),
            ],
          ),
           Space(height: 6.h,),
           Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const BodyText(text: mobileNumber,fontSize: 16,color: primaryColor,),
                      BodyText(
                        text: contactNumber,
                        color: bodyBlack,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       const BodyText(text: email,fontSize: 16,color: primaryColor,),
                      BodyText(
                        text: emailAddress,
                        color: bodyBlack,
                      ),
                    ],
                  )),
            ],
          ),
           Space(height:6.h ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const BodyText(text:address,fontSize: 16,color: primaryColor,),
                  BodyText(text: add,color: bodyBlack,),
                ],
              ),
              const Space(width: 4,),
              CustomButton(
                  buttonText: 'Ledger',
                  buttonTextSize: 11,
                  buttonTextColor: bodyWhite,
                  margin: 0,
                  radius: 18,
                  buttonWidth: 110,
                  buttonHeight: 36,
                  image: downloadLedger,
                  onClick: () {
                   // sendWhatappMessage();
                   //_sendFileOnWhatsApp();
                   // onPressed();
                  })
            ],
          ),
        ],
      ),
    );
  }

}

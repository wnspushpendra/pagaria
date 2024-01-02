import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';


/// ************** bottom sheet for filters **********************

void showCustomerDetailSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1), spreadRadius: 2),
              ]),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BodyText(
                          text: 'Customer Name : ',fontSize: 16.h,
                        ),
                        const BodyText(
                          text: 'abc',
                          color: primaryColor,
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
                                BodyText(text: mobileNumber,fontSize: 16.h,),
                                const BodyText(
                                  text: '879797987',
                                  color: primaryColor,
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BodyText(text: email,fontSize: 16.h,),
                                const BodyText(
                                  text: 'yuvi@gmail.com',
                                  color: primaryColor,
                                ),
                              ],
                            )),
                      ],
                    ),
                    Space(height:6.h ,),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(text:'Address',fontSize: 16.h,),
                              const BodyText(text: 'scheme no 54 indore', color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /*Positioned(
                  bottom: 0,
                  right: 0,
                  child: CustomButton(
                      buttonText: 'Ledger',
                      buttonTextSize: 12.h,
                      buttonTextColor: bodyWhite,
                      padding: 0.h,
                      radius: 17.h,
                      buttonWidth: 120.h,
                      buttonHeight: 32.h,
                      image: downloadLedger,
                      onClick: () {
                      }),
                )*/
              ],
            ),
          )));
}
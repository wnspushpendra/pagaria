import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/customer_detail.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerListItem extends StatelessWidget {
 // final Customer customerDetails;
  final User customerDetails;
  final String name;
  final String contactNumber;
  final String emailAddress;
  final String add;

  const CustomerListItem(
      {
        required this.customerDetails,
        required this.name,
      required this.contactNumber,
      required this.emailAddress,
      required this.add,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:   EdgeInsets.all(8.h),
      margin: EdgeInsets.all(4.h),
      alignment: Alignment.center,
      decoration: defaultDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      text: customerDetails.fullName.toString(),
                      color: bodyBlack,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  AssetButton(image: createOrder, onPressed: ()async =>ChangeRoutes.openProductScreen(context, await getUser(), customerDetails/*customerDetails.id.toString()*/) ),
                  //AssetButton(image: createOrder, onPressed: () => Navigator.pushReplacementNamed(context, productRoute,arguments: 'create')),
                  AssetButton(image: visibility, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: CustomerDetailModal(customerDetails: customerDetails),)),
                  AssetButton(image: paymentIcon, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: CustomerDetailModal(index: 2,customerDetails: customerDetails))),
                  AssetButton(image: history, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: CustomerDetailModal(index: 1,customerDetails: customerDetails,fromMenu: false))),
                ],
              ),
            ],
          ),
           const Space(height: 6,),
           Row(
            children: [
              Expanded(
                flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const BodyText(text: mobileNumber,fontSize: 16,color: primaryColor,align: TextAlign.start,),
                      BodyText(
                        text: customerDetails.contactNo.toString(),
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
                      NormalText(text: customerDetails.email.toString(), color: bodyBlack,),
                    ],
                  )),
            ],
          ),
           const Space(height:6 ,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customerDetails.address != null ? Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const BodyText(text:address,fontSize: 16,color: primaryColor,),
                    NormalText(text: "${customerDetails.address},${customerDetails.city},${customerDetails.state},${customerDetails.zipCode}",color: bodyBlack,),
                  ],
                ),
              ): const SizedBox.shrink(),
              const Space(width: 4,),

              Container(
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
                    onClick: () => Navigator.pushReplacementNamed(context, ledgerRoute,arguments: LedgerArgument(distributorId:  customerDetails.id.toString(),showAppbar: true))),
              )
            ],
          ) ,
        ],
      ),
    );
  }

}

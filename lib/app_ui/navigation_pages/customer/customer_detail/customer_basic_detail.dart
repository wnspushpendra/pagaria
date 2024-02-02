import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/row_detail_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';


class CustomerBasicDetails extends StatelessWidget {
  final Customer customer;
  const CustomerBasicDetails( {required this.customer,super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding:  EdgeInsets.all(16.h),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ProfileImageWidget(
                        showIcon: false,
                          networkUrl: customer.profileImageUrl.toString(), onFileChange: (file){})),
                  const Space(height: 10,),
                   RowDetailWidget(titleLeft: firmName, valueLeft: customer.firmName.toString(), titleRight: customerName, valueRight: customer.fullName.toString(),),
                   RowDetailWidget(titleLeft: mobileNumber, valueLeft: customer.contactNo.toString(), titleRight: panCardNumber, valueRight: customer.panCardNo.toString(),),
                   RowDetailWidget(titleLeft: gstNumber, valueLeft: customer.gstNo.toString() , titleRight: aadharNumber, valueRight: customer.aadharNo.toString(),),
                   RowDetailWidget(titleLeft: email, valueLeft:  customer.email.toString(), titleRight: address, valueRight: '',showSingleDetail: true,),
                  const BodyText(text:'$address :',fontSize: 16),
                  BodyText(
                    text: "${customer.address},${customer.city},${customer.state},${customer.zipCode}",
                    align: TextAlign.start,
                    color: primaryColor,
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              right: 0,
              left: 0,
              child: CustomButton(buttonText: 'Ledger Book',
                margin: 0,radius: 0,
                image: downloadLedger,
                onClick: (){},))
        ],
      ),
    );
  }
}

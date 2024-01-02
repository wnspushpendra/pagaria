import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/row_detail_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';


class CustomerBasicDetails extends StatelessWidget {

  const CustomerBasicDetails({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImageWidget(networkUrl: networkImage, onFileChange: (file){}),
                  const Space(height: 10,),
                  const RowDetailWidget(titleLeft: firmName, valueLeft: 'new firm', titleRight: customerName, valueRight: 'abc',),
                  const RowDetailWidget(titleLeft: mobileNumber, valueLeft: '989897989', titleRight: panCardNumber, valueRight: 'abcd9788dc',),
                  const RowDetailWidget(titleLeft: gstNumber, valueLeft: 'klsdjd ', titleRight: aadharNumber, valueRight: '1212223323',),
                  const RowDetailWidget(titleLeft: email, valueLeft: 'yuvi@gmail.com ', titleRight: address, valueRight: '54 vijay nagar indore',),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              right: 0,
              left: 0,
              child: CustomButton(buttonText: 'Ledger Book',
                padding: 0,radius: 0,
                image: downloadLedger,
                onClick: (){},))
        ],
      ),
    );
  }
}

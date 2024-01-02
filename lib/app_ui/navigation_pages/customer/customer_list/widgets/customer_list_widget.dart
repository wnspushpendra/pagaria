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
      padding:  EdgeInsets.all(12.h),
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
                  AssetButton(image: history, onPressed: () => Navigator.pushReplacementNamed(context, customerDetailRoute,arguments: 1)),
                  AssetButton(image: paymentIcon, onPressed: () => Navigator.pushReplacementNamed(context, paymentRoute,arguments: 3)),
                  AssetButton(image: createOrder, onPressed: () => Navigator.pushReplacementNamed(context, createOrderRoute)),
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
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const BodyText(text:address,fontSize: 16,color: primaryColor,),
                    BodyText(text: add, color: bodyBlack,),
                  ],
                ),
              ),
              const Space(width: 6,),
              CustomButton(
                  buttonText: 'Ledger',
                  buttonTextSize: 11,
                  buttonTextColor: bodyWhite,
                  padding: 0,
                  radius: 18,
                  buttonWidth: 128,
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

  void _sendFileOnWhatsApp() async {
    String filePath = pdfUrls;

    // Check if WhatsApp is installed
/*    bool whatsappInstalled = await canLaunch('whatsapp://');
    if (!whatsappInstalled) {
      print('WhatsApp is not installed on the device.');
      return;
    }*/

    // Launch WhatsApp with the file attached
    var phone = '8962904087';
    String whatsappUrl = 'https://wa.me?$phone=&text=$filePath';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      print('Could not launch WhatsApp.');
    }
  }
}

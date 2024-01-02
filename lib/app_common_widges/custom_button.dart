import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';


class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onClick;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? buttonTextSize;
  final String? image;
  final double? padding;
  final double? radius;
  final bool? showLoading;

  const CustomButton(
      {required this.buttonText,
      required this.onClick,
      this.buttonColor,
        this.buttonTextColor,
      this.buttonHeight,
      this.buttonWidth,
      this.buttonTextSize,
      this.image,
        this.padding,
        this.radius,
        this.showLoading,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth?? MediaQuery.of(context).size.width.h,
      height: buttonHeight ?? 52.h,
      margin:  EdgeInsets.symmetric(vertical: padding??24.h),
      child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor??primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius??12.h)),
              ))),
          onPressed: () => onClick(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyText(text:buttonText.toUpperCase(),fontSize: buttonTextSize,fontWeight: FontWeight.bold,color: buttonTextColor?? bodyWhite, ),
              showLoading != null ? const CustomProgressBar() : const SizedBox.shrink(),
              const Space(width: 4,),
              image != null
                  ? Row(
                children: [
                  Image.asset(
                    image!,
                    width: 24.h,
                    height: 24.h,
                    color: bodyWhite,
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ],
          )),
    );
  }
}

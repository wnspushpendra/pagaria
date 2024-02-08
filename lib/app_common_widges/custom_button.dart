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
  final Color? borderColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? buttonTextSize;
  final String? image;
  final double? margin;
  final double? radius;
  final bool? showLoading;

  const CustomButton(
      {required this.buttonText,
      required this.onClick,
      this.buttonColor,
        this.buttonTextColor,
        this.borderColor,
      this.buttonHeight,
      this.buttonWidth,
      this.buttonTextSize,
      this.image,
        this.margin,
        this.radius,
        this.showLoading,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth?? MediaQuery.of(context).size.width.h,
      height: buttonHeight ?? 52.h,
      margin:  EdgeInsets.symmetric(vertical: margin??24.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: buttonColor ?? primaryColor,
        borderRadius: BorderRadius.circular(radius ?? 20),
        border: Border.all(width: 1,color: borderColor ?? buttonColor ?? primaryColor)
      ),
      child: TextButton(
        onPressed: ()   => onClick(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: BodyText(text:buttonText.toUpperCase(),fontSize: buttonTextSize,fontWeight: FontWeight.bold,color: buttonTextColor?? bodyWhite, )),
            showLoading ==true ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const CustomProgressBar(widthV: 20,heightV: 20,color: bodyWhite,)) :  Container(),
            image != null
                ? Padding(
                  padding: const EdgeInsets.fromLTRB(6,0,0,0),
                  child: Image.asset(
                    image!,
                    width: 24,
                    height: 24,
                    color: bodyWhite,
                  ),
                )
                : const SizedBox.shrink(),
          ],
        )),
    );


  }
}

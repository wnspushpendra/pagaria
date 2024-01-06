import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

get appTheme => ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: primaryColor,
  ),
  primaryColor: bodyWhite,
  scaffoldBackgroundColor: bodyWhite,
  textTheme:  TextTheme(
    headlineMedium: TextStyle(fontSize: 26.h,color: primaryColor,fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 24.h,color: primaryColor,fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 22.h,fontWeight: FontWeight.bold,color: primaryColor),
    titleSmall: TextStyle(fontSize: 20.h,fontWeight : FontWeight.bold,color: primaryColor),
    bodyLarge: TextStyle(fontSize: 18.h,color: bodyWhite ),
    bodyMedium: TextStyle(fontSize: 16.h,color: bodyLightBlack ),
    bodySmall: TextStyle(fontSize: 14.h,color: bodyBlack ),
  ),
  dialogBackgroundColor: bodyWhite,
);

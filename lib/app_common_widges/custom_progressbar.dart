import 'package:flutter/material.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  final double? widthV;
  final double? heightV;
  final Color? color;
  const CustomProgressBar({this.widthV,this.heightV,this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:widthV ?? MediaQuery.of(context).size.width,
      height: heightV ?? MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child:  SizedBox(
        width: 30, height: 30,
          child: CircularProgressIndicator(color: color ?? primaryColor,)),
    );;
  }
}

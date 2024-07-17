import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
 final String text;
 final Color? color;
 final TextAlign? align;
 final double? fontSize;
 final FontWeight? fontWeight;

  const HeadingText({required this.text, this.color,this.align,this.fontSize,this.fontWeight,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
     textAlign: align,
     style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color,fontSize: fontSize,fontWeight: fontWeight ?? FontWeight.bold),);
  }
}

import 'package:flutter/material.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';


class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? align;
  final  double? fontSize;
  final  FontWeight? fontWeight;

  const BodyText({required this.text, this.color,
    this.align,
    this.fontSize,
    this.fontWeight,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? bodyBlack),
    );
  }
}

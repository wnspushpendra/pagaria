import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;

  const NormalText({required this.text, this.color,
    this.textSize,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color,fontSize: textSize),
    );
  }
}

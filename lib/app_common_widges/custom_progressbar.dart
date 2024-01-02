import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double? widthV;
  final double? heightV;
  const CustomProgressBar({this.widthV,this.heightV,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:widthV ?? MediaQuery.of(context).size.width,
      height: heightV ?? MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 30, height: 30,
          child: CircularProgressIndicator()),
    );;
  }
}

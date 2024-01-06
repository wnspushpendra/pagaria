import 'package:flutter/material.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class AssetButton extends StatelessWidget {
  final String image;
  final Function onPressed;
  final double? padding;

  const AssetButton({required this.image,required this.onPressed,this.padding,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onPressed(),
      child: Padding(
        padding:  EdgeInsets.all(padding??4),
          child: Image.asset(image,width: 24,height: 24,color: primaryColor,)),
    );
  }
}

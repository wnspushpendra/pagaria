import 'package:flutter/material.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class AssetButton extends StatelessWidget {
  final String image;
  final Function onPressed;

  const AssetButton({required this.image,required this.onPressed,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(4),
          child: Image.asset(image,width: 24,height: 24,color: primaryColor,)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class AssetButton extends StatelessWidget {
  final String image;
  final Function onPressed;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final Color? color;
  final double? width;
  final double? height;

  const AssetButton({required this.image,required this.onPressed,this.paddingVertical,this.paddingHorizontal,this.color,this.width,this.height,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onPressed(),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical : paddingVertical??4,horizontal: paddingHorizontal ?? 4 ),
          child: Image.asset(image,width: width ?? 24,height:height ?? 24,color:color?? primaryColor,)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class ProductCategoryListItem extends StatefulWidget {
  final String category;
   final Color color;


    const ProductCategoryListItem({super.key,  required this.category,required this.color});

  @override
  State<ProductCategoryListItem> createState() => _ProductCategoryListItemState();
}

class _ProductCategoryListItemState extends State<ProductCategoryListItem> {



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.fromLTRB(5,10,5,10),
      padding: const EdgeInsets.fromLTRB(8,4,8,4),
      alignment: Alignment.center,
      decoration:   BoxDecoration(
        color:widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child:  BodyText(text: widget.category,fontSize : 16,color: bodyWhite,fontWeight: FontWeight.bold,),
    );
  }
}

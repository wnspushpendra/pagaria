import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';

class CustomErrorWidget  extends StatelessWidget {
  final bool? validate;
  final String errorMessage;

  const CustomErrorWidget ({required this.validate,required this.errorMessage,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (validate == null || validate == true) {
      return const SizedBox.shrink();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child:  BodyText(text: errorMessage,fontSize: 14,fontWeight : FontWeight.normal,color: Colors.red,align: TextAlign.start,));
    }
  }
}

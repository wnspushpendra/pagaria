import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';



AppBar homeAppBarWidget(BuildContext context, String title, Function onPressed,) =>
    AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu),),
      title: BodyText(text: title,color: bodyWhite,fontWeight: FontWeight.bold,),
      actions: [
        IconButton(onPressed: () => onPressed()
        , icon: const Icon(Icons.logout_rounded,color: bodyWhite,))
      ],
    );

get defaultDecoration =>
    BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: bodyWhite,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0),
          blurRadius: 6.0,
        ),
      ],
    );


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class CategoryItem extends StatelessWidget {
  Categories category;
   CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        category.catImageUrl == null ?
            Image.asset(logo,height: 76.h,width: 120.h,) :
        Image.network(
          category.catImageUrl!,
          height: 76.h,
        ),
        const Space(
          height: 2,
        ),
        BodyText(
          text: category.catName!,
          fontSize: 12,
        )
      ],
    );
  }
}

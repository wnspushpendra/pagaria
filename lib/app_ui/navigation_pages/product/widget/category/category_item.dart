import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  Categories category;
   CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          category.catImageUrl!,
          height: 88,
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

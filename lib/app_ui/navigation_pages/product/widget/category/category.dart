import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/widget/category/category_item.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class Category extends StatefulWidget {
  final List<Categories> categoryList;
  final ValueChanged<String> onClick;
  const Category({super.key, required this.categoryList,required this.onClick});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final ScrollController _controller = ScrollController();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            controller:_controller ,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.categoryList.length,
              itemBuilder: (context, index) {
                var category = widget.categoryList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    widget.onClick(category.id.toString());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin:  EdgeInsets.symmetric(horizontal: 6.h,vertical: 6.h),
                    padding:  EdgeInsets.symmetric(horizontal: 6.h,vertical: 1.h),
                    decoration: BoxDecoration(
                        color: bodyWhite,
                        border: Border.all(
                            width: 0.5,
                            color: selectedIndex == index
                                ? primaryColor
                                : bodyLightBlack),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(4))),
                    child: CategoryItem( category : category),
                  ),
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  moveToPreviousItem();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            IconButton(
                onPressed: () {
                  moveToNextItem();
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined)),
          ],
        )

      ],
    );;
  }
  void moveToNextItem() {
    _controller.animateTo(
      _controller.offset + 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void moveToPreviousItem() {
    _controller.animateTo(
      _controller.offset - 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

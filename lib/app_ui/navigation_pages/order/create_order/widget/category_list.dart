import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class CategoryList extends StatefulWidget {
  List<String> categoryList;
  CategoryList({required this.categoryList,super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.categoryList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var color = selectedIndex == index ? Colors.green : bodyWhite;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
                padding: const EdgeInsets.fromLTRB(4,4,4,4),
                color: color,
                child:   Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                           borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: networkImage,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const Space(width: 4,),
                        Flexible(
                          child: BodyText(
                            text: widget.categoryList[index].toString(),fontSize: 14,
                            color: color == bodyWhite? bodyBlack : bodyWhite,
                          ),
                        ),
                      ],
                    ),

                  ],
                )),
          );
        });
  }
}

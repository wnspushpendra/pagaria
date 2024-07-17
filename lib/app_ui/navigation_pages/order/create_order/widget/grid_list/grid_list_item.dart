import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/product_count.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class GridListItem extends StatefulWidget {
  final String category;
  final String productName;
  final String? from;
  final ValueChanged<int> updateQuantity;

  const GridListItem({required this.category,required this.productName,this.from,required this.updateQuantity,super.key});

  @override
  State<GridListItem> createState() => _GridListItemState();
}

class _GridListItemState extends State<GridListItem> {
  bool addItem = false;
  late int count;



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin:  EdgeInsets.all(4.h),
      decoration: defaultDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:  const EdgeInsets.fromLTRB(2, 6, 2, 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45.0),
                  child: CachedNetworkImage(
                    imageUrl:
                    "https://pbs.twimg.com/profile_images/1075240418936160256/BYPSMMdz_400x400.jpg",
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          BodyText(text: widget.productName,),
           Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const BodyText(text: "${rupeesSymbol}5000", fontSize: 12,),
                        const Space(width: 4,),
                        widget.from != null ?
                        addItem ? Count(
                          count: count,
                          onChange: (int value) {
                            setState(() {
                              count = value;
                              widget.updateQuantity(count);
                              if (value == 0) {
                                addItem = false;
                              }
                            });
                          },
                        )
                            : CustomButton(
                            buttonText: 'Add',
                            buttonTextSize: 14,
                            buttonTextColor: bodyWhite,
                            margin: 0,
                            radius: 45,
                            buttonWidth: 90,
                            buttonHeight: 30,
                            onClick: () => setState(() {
                              addItem = true;
                              count = 1;
                              widget.updateQuantity(count);
                            })):const SizedBox.shrink()
                      ],
                    )),

              ],
            ),
          )
          /*addItem ? Count(
            count: count,
            onChange: (int value) {
              setState(() {
                count = value;
                widget.updateQuantity(count);
                if (value == 0) {
                  addItem = false;
                }
              });
            },
          )
              : CustomButton(
              buttonText: 'Add',
              buttonTextSize: 14,
              buttonTextColor: bodyWhite,
              padding: 0,
              radius: 45,
              buttonWidth: 65,
              buttonHeight: 30,
              onClick: () => setState(() {
                addItem = true;
                count = 1;
                widget.updateQuantity(count);
              }))*/
        ],
      ),
    );;
  }
}

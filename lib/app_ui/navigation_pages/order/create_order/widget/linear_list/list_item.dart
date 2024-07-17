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

class ListItem extends StatefulWidget {
  final String category;
  final String productName;
  final String? from;
  final ValueChanged<int> updateQuantity;

  const ListItem({super.key,  required this.category,
    required this.productName,this.from,
    required this.updateQuantity
   });

  @override
  State<ListItem> createState() =>
      _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool addItem = false;
  late int count;

  @override
  Widget build(BuildContext context) {
       return Container(
      padding:  const EdgeInsets.all(8),
      margin:  const EdgeInsets.fromLTRB(2, 8, 4, 2),
      decoration: defaultDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                   // borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: "https://pbs.twimg.com/profile_images/1075240418936160256/BYPSMMdz_400x400.jpg",
                      height: 70,
                      width: 70,
                    ),
                  ),
                   const Space(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BodyText(text: widget.productName,align: TextAlign.start,fontWeight: FontWeight.bold,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(text: "$rupeesSymbol 5000",fontSize: 14.h,align: TextAlign.start,color: primaryColor, ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: AlignmentDirectional.centerEnd,
                              child: widget.from != null ? addItem ? SizedBox(
                                width: 110,
                                child: Count(count: count, onChange: (int value) {
                                  setState(() {
                                    count = value;
                                    widget.updateQuantity(count);
                                    if (value == 0) {
                                      addItem = false;
                                    }
                                  });
                                },),
                              ) :
                              CustomButton(
                                  buttonText: 'Add',
                                  buttonTextSize: 11,
                                  buttonTextColor: bodyWhite,
                                  margin: 0,
                                  radius: 45,
                                  buttonWidth: 85,
                                  buttonHeight: 30,
                                  onClick: () =>
                                      setState(() {
                                        count = 1;
                                        widget.updateQuantity(count);
                                        addItem = true;
                                      })
                              ) : const SizedBox.shrink(),
                            )


                            ],
                          ),
                    /*    const Space(height: 4,),
                        addItem ? Count(count: count, onChange: (int value) {
                          setState(() {
                            count = value;
                            widget.updateQuantity(count);
                            if (value == 0) {
                              addItem = false;
                            }
                          });
                        },) :
                        CustomButton(
                            buttonText: 'Add',
                            buttonTextSize: 14.h,
                            buttonTextColor: bodyWhite,
                            padding: 0,
                            radius: 45.h,
                            buttonWidth: 65.h,
                            buttonHeight: 30.h,
                            onClick: () =>
                                setState(() {
                                  count = 1;
                                  widget.updateQuantity(count);
                                  addItem = true;
                                })
                        )*/
                      ],
                    ),
                  ),
                ],
              ),
              BodyText(text: "its product show description",fontSize: 10.h, align: TextAlign.start,),

            ],
          ),

        ],
      ),
    );




    /*return Container(
      padding: const EdgeInsets.all(8),
      // margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: const EdgeInsets.fromLTRB(2, 8, 4, 2),
      decoration: defaultDecoration,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: "https://pbs.twimg.com/profile_images/1075240418936160256/BYPSMMdz_400x400.jpg",
                  height: 40,
                  width: 40,
                ),
              ),
              const Space(width: 8,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BodyText(
                      text: widget.productName, fontSize: 16,
                    ),
                  ],
                ),
              ),
              addItem ? Count(count: count, onChange: (int value) {
                setState(() {
                  count = value;
                  widget.updateQuantity(count);
                  if (value == 0) {
                    addItem = false;
                  }
                });
              },) :
              CustomButton(
                  buttonText: 'Add',
                  buttonTextSize: 14,
                  buttonTextColor: bodyWhite,
                  padding: 0,
                  radius: 45,
                  buttonWidth: 90,
                  buttonHeight: 30,
                  onClick: () =>
                      setState(() {
                        addItem = true;
                        count = 1;
                      })
              )
            ],
          ),

        ],
      ),
    );*/
  }
}

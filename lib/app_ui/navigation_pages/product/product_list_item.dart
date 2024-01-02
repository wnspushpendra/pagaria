import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class ProductListItem extends StatelessWidget {
  final String category;
  final String productName;
  final String price;
  final String quantity;
  final String image;

  const ProductListItem(
      { required this.category,
       required this.productName,
       required this.price,
        required this.quantity,
        required this.image,
       super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: defaultDecoration,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              const Space(width: 8,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const BodyText(text: 'Name ',fontSize: 16,align: TextAlign.start,),
                          BodyText(text: productName,color: primaryColor,),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const BodyText(
                            text: 'Price ',fontSize: 16,
                          ),
                          BodyText(
                            text: price,color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                     Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const BodyText(
                            text: 'Quantity ',fontSize: 16,
                          ),
                          BodyText(
                            text: quantity,color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}

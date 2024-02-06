import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class DeleteProductBottomSheet extends StatelessWidget {
  final CartItem cartItem;
  const DeleteProductBottomSheet({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BodyText(text: cartItem.productDetails!.prodName!,fontSize: 30,fontWeight: FontWeight.bold,),
          const Space(height: 8,),
          const Divider(height: 1,color: bodyLightBlack,),
          const Space(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(text: 'Quantity',fontSize: 20,fontWeight: FontWeight.bold,),
                    BodyText(text: cartItem.quantity!,fontSize: 16,),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(text: 'Amount',fontSize: 20,fontWeight: FontWeight.bold,),
                    BodyText(text: cartItem.amount.toString(),fontSize: 16,),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CustomButton(buttonText: 'Yes',
                      radius: 8,
                      onClick: (){})),
              const Space(width: 10,),
              Expanded(
                flex: 1,
                  child: CustomButton(buttonText: 'No',
                      buttonColor: bodyWhite, radius: 8,
                      buttonTextColor: bodyBlack,
                      onClick: (){})),

            ],
          ),
        ],
      ),
    );
  }
}
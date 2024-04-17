import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

Future<String?> quantityDialog(BuildContext context, CartItem cartItem,
    Product product, String prodMinQty) async {
  TextEditingController quantityController =
      TextEditingController(text: cartItem.quantity.toString());

  showDialog(
    context: context,
    builder: (context) {
      bool loading = false;
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        contentPadding: EdgeInsets.zero,
        content: BlocConsumer<CheckOutBloc, CheckOutState>(
          listener: (context, state) {
            if (state is CheckOutSuccess) {
              var item = state.cartItem;
              Future.value(item!.quantity.toString());
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Container(
              height: 218,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: defaultDecoration,
              child: Column(
                children: [
                  BodyText(text: product.prodName!),
                  CustomTextField(
                    controller: quantityController,
                    maxLength: 6,
                    isMobile: true,
                    inputFormatter: InputFieldFormatter.numberFormat,
                    hint: 'Quantity',
                    label: 'Quantity',
                    onTextChange: (bool value) {},
                  ),
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            buttonText: 'Cancel',
                            buttonHeight: 40,
                            buttonTextSize: 14,
                            radius: 20,
                            margin: 0,
                            onClick: () {
                              Future.value(null);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const Space(width: 10),
                        Expanded(
                            flex: 1,
                            child: CustomButton(
                              buttonText: 'Ok',
                              buttonHeight: 40,
                              buttonTextSize: 14,
                              radius: 20,
                              margin: 0,
                              onClick: () {
                                String quantity = quantityController.text;
                                if (product.prodInventoryType == 'yes') {
                                  if (int.parse(product.availStock!) >= int.parse(quantity)) {
                                    if (int.parse(prodMinQty) <= int.parse(quantity)) {
                                      context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty: quantityController.text, cartItemId: cartItem.id.toString()));
                                    } else {
                                      snackBar(context, 'you can create min $prodMinQty quantity');
                                    }
                                  } else {
                                    snackBar(context, '${product.prodName} ${product.availStock} quantity available in stock.');
                                  }
                                } else {
                                  if (int.parse(prodMinQty) <= int.parse(quantity)) {
                                    context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty: quantityController.text, cartItemId: cartItem.id.toString()));
                                  } else {
                                    snackBar(context, 'you can create min $prodMinQty quantity');
                                  }
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );

  return Future.value(null);
}

Future<String?> updateQuantityDialog(
  BuildContext context,
  cartId,
  String productName,
  String cartQty,
  String cartMinimumQty,
) async {
  TextEditingController quantityController =
      TextEditingController(text: cartQty);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        contentPadding: EdgeInsets.zero,
        content: BlocConsumer<CheckOutBloc, CheckOutState>(
          listener: (context, state) {
            if (state is CheckOutSuccess) {
              var item = state.cartItem;
              Future.value(item!.quantity.toString());
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Container(
              height: 218,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: defaultDecoration,
              child: Column(
                children: [
                  BodyText(text: productName),
                  CustomTextField(
                    controller: quantityController,
                    maxLength: 4,
                    inputFormatter: InputFieldFormatter.numberFormat,
                    hint: 'Quantity',
                    label: 'Quantity',
                    onTextChange: (bool value) {},
                  ),
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            buttonText: 'Cancel',
                            buttonHeight: 40,
                            buttonTextSize: 14,
                            radius: 20,
                            margin: 0,
                            onClick: () {
                              Future.value(null);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const Space(width: 10),
                        Expanded(
                            flex: 1,
                            child: CustomButton(
                              buttonText: 'Ok',
                              buttonHeight: 40,
                              buttonTextSize: 14,
                              radius: 20,
                              margin: 0,
                              onClick: () {
                                String quantity = quantityController.text;
                                if (int.parse(cartMinimumQty) <=
                                    int.parse(quantity)) {
                                  context.read<CheckOutBloc>().add(
                                      CheckOutUpdateQuantityEvent(
                                          productQty: quantityController.text,
                                          cartItemId: cartId.toString()));
                                } else {
                                  snackBar(context,
                                      'you need to add for create order min ${cartMinimumQty} quantity');
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );

  return Future.value(null);
}

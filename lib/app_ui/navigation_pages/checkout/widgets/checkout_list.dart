import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/update_qty_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CheckOutList extends StatefulWidget {
 final List<CartItem> cartList;
 final bool? productAddRemove;

  const CheckOutList({required this.cartList,required this.productAddRemove,super.key});

  @override
  State<CheckOutList> createState() => _CheckOutListState();
}

class _CheckOutListState extends State<CheckOutList> {
  int selectedIndex = -1;
  String? quantity;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 120),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
      child: GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              mainAxisExtent: 100),
          itemCount: widget.cartList.length,
          itemBuilder: (context, index) {
            selectedIndex = index;
            CartItem cartItem = widget.cartList[index];
            quantity = cartItem.quantity.toString();
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: defaultDecoration,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    imageUrl: cartItem.productDetails!.prodImageUrl!,
                    width: 80,
                    height: 80,
                  ),
                  const Space(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyText(
                              text: cartItem.productDetails!.prodName!,
                              fontWeight: FontWeight.bold,
                            ),
                            BlocConsumer<ProductBloc, ProductState>(
                              listener: (context, state) {
                                if (state is CartProductRemoveSuccess) {
                                  if(cartItem.id.toString() == state.message){
                                   widget. cartList.removeAt(index);
                                    setState(() {});
                                  }
                                }
                                if (state is ProductError) {
                                  snackBar(context, state.error);
                                }
                              },
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () {
                                      selectedIndex = index;
                                      context.read<ProductBloc>().add(RemoveProductCartEvent(cartItemId: cartItem!.id.toString()));
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      size: 28,
                                      color: bodyLightBlack,
                                    ));
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyText(
                              text: rupeesSymbol + cartItem.amount.toString(),
                              fontWeight: FontWeight.bold, color: primaryColor,),
                            /*    SizedBox(
                                                  height: 36,
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          IconButton(
                                                              padding: const EdgeInsets.all(0),
                                                              onPressed: () => updateQty('remove',cartItem),
                                                              icon: const Icon(
                                                                Icons.remove_circle,
                                                                color: primaryColor,
                                                                size: 28,
                                                              )),
                                                          BodyText(
                                                            text: quantity!,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              onPressed: () => updateQty('add',cartItem),
                                                              icon: const Icon(
                                                                Icons.add_circle_outlined,
                                                                color: primaryColor,
                                                                size: 28,
                                                              )),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 30,height: 30,
                                                        child: AssetButton(image: edit,
                                                          onPressed: () {
                                                          Future<String?> futureQty = quantityDialog(context, cartItem);

                                                          },),
                                                      )
                                                    ],

                                                  ),
                                                )*/
                            UpdateQuantityWidget(cartItem: cartItem, quantity: quantity!, productAddRemove: widget.productAddRemove)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

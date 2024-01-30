import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_common_widges/update_product_qty.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/update_qty_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/widget/bottom_widget_checkout.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/widget/checkout_list.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/cart/update_cart_qty.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CheckOutScreen extends StatefulWidget {
  final String distributorId;
  const CheckOutScreen({required this.distributorId,super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool checkOutLoading = true;
  List<CartItem> cartList = [];
  CartItem? cartItem;
  String productAmount = '';
  int selectedIndex = -1;
  String? quantity;
  bool? productAddRemove;

  @override
  void initState() {
    super.initState();
    context.read<CheckOutBloc>().add(CheckOutListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          context,
          'Checkout',
          () => Navigator.pushReplacementNamed(context, productRoute, arguments: 'create')),
      body: BlocConsumer<CheckOutBloc, CheckOutState>(
        listener: (BuildContext context, CheckOutState state) {
          if (state is CheckOutLoading) {
            setState(() => checkOutLoading = true);
          }
          if (state is CheckOutSuccess) {
            checkOutLoading = false;
            if(state.cartList != null && state.productAmount != null){
              cartList = state.cartList!;
              productAmount = state.productAmount!;
            }
            if(state.cartItem != null){
              for (var element in cartList) {
                if(element.productId ==  state.cartItem!.productId){
                  element.quantity = state.cartItem!.quantity;
                  element.amount = state.cartItem!.amount;
                  if(productAddRemove== true){
                    productAmount = '${int.parse(productAmount)+state.cartItem!.amount!}';
                  }else{
                    productAmount = '${int.parse(productAmount)-state.cartItem!.amount!}';
                  }
                }
              }
            }
            setState(() {});
          }
          if (state is CheckOutError) {
            checkOutLoading = false;
            snackBar(context, state.error);
            setState(() {});
          }
        },
        builder: (BuildContext context, CheckOutState state) {
          return checkOutLoading
              ? const Center(
                  child: CustomProgressBar(),
                )
              : cartList.isEmpty
                  ? Center(
                      child: MaterialButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, productRoute, arguments: 'create'),
                        child: const BodyText(text: 'No item added click me to add  ', fontSize: 14),
                      ),
                    )
                  : Stack(
                      children: [
                        CheckOutList(cartList: cartList, productAddRemove: productAddRemove) ,

                       /* Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                          padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 500,
                                      mainAxisExtent: 100),
                              itemCount: cartList.length,
                              itemBuilder: (context, index) {
                                selectedIndex = index;
                                CartItem cartItem = cartList[index];
                                quantity = cartItem.quantity;
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
                                                        cartList.removeAt(index);
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
                                            *//*    SizedBox(
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
                                                )*//*
                                                UpdateQuantityWidget(cartItem: cartItem, quantity: quantity!, productAddRemove: productAddRemove)
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),*/
                        Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: CheckoutBottomWidget(totalCartAmount: productAmount,distributorId : widget.distributorId)
                          /*Container(
                              decoration: defaultDecoration,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 6),
                                    child: BodyText(
                                      text:
                                          'Cart Amount : $rupeesSymbol$productAmount',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomButton(
                                    buttonText: 'Place Order',
                                    radius: 0,
                                    margin: 0,
                                    onClick: () {},
                                  ),
                                ],
                              ),
                            )*/)
                      ],
                    );
        },
      ),
    );
  }

  updateQty(String from,CartItem item) {
    var qty;
    if(from == 'add'){
      productAddRemove = true;
      qty = '${int.parse(item.quantity!)+1}';
      context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));
    /*  if(int.parse(item.productDetails!.prodInventory!) < qty){
      }*/
    }else{
      productAddRemove = false;
      if(int.parse(item.quantity!) != 1 ){
        qty = int.parse(item.quantity!)-1;
      }
      if(int.parse(item.productDetails!.prodMinDistrubutorQty!)  <=  qty){
         context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));
      }else{
        snackBar(context, 'You can order minimum ${item.productDetails!.prodMinDistrubutorQty} for this item');
      }
    }

  //  context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));

  }
}

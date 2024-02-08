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
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/widget/bottom_sheet_delete_item.dart';
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
  bool checkOutDeleteLoading = false;
  List<CartItem> cartList = [];
  CartItem? cartItem;
  String productAmount = '';
  int singleItemAmount = 0;
  int selectedIndex = -1;
  String? quantity;
  bool? productAddRemove;
  bool showDelete = true;
  int? cartId;
  String prodMinQty = '';
  String userRole = '';

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
              userRole = state.userRole!;
            }
            if(state.cartItem != null){
              for (var element in cartList) {
                if(element.productId ==  state.cartItem!.productId){
                  productAmount = state.cartTotal!;
                  element.quantity = state.cartItem!.quantity;
                  element.amount = state.cartItem!.amount;

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
                        Container(
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
                                prodMinQty = (userRole == '4' ?  cartItem.productDetails!.prodMinDistrubutorQty! : cartItem.productDetails!.prodMinCustomerQty)!;

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
                                                    if(state is CartProductRemoveLoading){
                                                      setState(() => checkOutDeleteLoading = true);
                                                    }
                                                    if (state is CartProductRemoveSuccess) {
                                                      checkOutDeleteLoading = false;
                                                      if(cartItem.id.toString() == state.message){
                                                        productAmount = (int.parse(productAmount) - cartItem.amount!).toString();
                                                        cartList.removeAt(index);
                                                        setState(() {});
                                                      }
                                                    }
                                                    if (state is ProductError) {
                                                      showDelete = true;
                                                      checkOutDeleteLoading = false;
                                                      setState(() {});
                                                      snackBar(context, state.error);
                                                    }

                                                  },
                                                  builder: (context, state) {
                                                    return cartItem.id == cartId && checkOutDeleteLoading ?
                                                        const Padding(
                                                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                            child: CustomProgressBar(widthV: 15,heightV: 15,)) :
                                                    cartItem.id != cartId  ? IconButton(
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return DeleteProductBottomSheet(cartItem : cartItem,
                                                                cartItemId: (int value) {
                                                                  selectedIndex = index;
                                                                  checkOutDeleteLoading = true;
                                                                  setState(() => cartId = cartItem.id!);
                                                                },);
                                                            },
                                                          );
                                   /*                       selectedIndex = index;
                                                          checkOutDeleteLoading = true;
                                                          setState(() => cartId = cartItem.id!);
                                                          context.read<ProductBloc>().add(RemoveProductCartEvent(cartItemId: cartItem.id.toString()));*/
                                                        },
                                                        icon: const Icon(
                                                          Icons.close_sharp,
                                                          size: 28,
                                                          color: bodyLightBlack,
                                                        )) : Container();
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
                                               UpdateQuantityWidget(cartItem: cartItem, productName : cartItem.productDetails!.prodName!,quantity: quantity!,distributorMinQty: prodMinQty, productAddRemove: productAddRemove)
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: CheckoutBottomWidget(totalCartAmount: productAmount,distributorId : widget.distributorId)
                          )
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
      singleItemAmount = item.amount!;
      context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));
    /*  if(int.parse(item.productDetails!.prodInventory!) < qty){
      }*/
    }else{
      productAddRemove = false;
      if(int.parse(item.quantity!) != 1 ){
        qty = int.parse(item.quantity!)-1;
        singleItemAmount = item.amount!;
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

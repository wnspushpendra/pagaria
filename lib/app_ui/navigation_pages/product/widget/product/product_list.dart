import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_common_widges/update_product_qty.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/product_count.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/update_qty_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/argument_modal/ProductArgument.dart';
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductList extends StatefulWidget {
  final String userRole;
  final List<Product> productList;
  final String? distributorId;
  // final String from;

  const ProductList({required this.userRole,required this.productList, super.key, required this.distributorId,});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController quantityController = TextEditingController();
  bool addItem = false;
  late int count;
  CartProduct cartProduct = CartProduct();
  CartItem cartValue = CartItem();
  int selectedIndex = -1;
  String? quantity;
  String? productPrice;
  bool? productAddRemove;
  int? productId;
  bool cartLoading = false;
  String prodMinQty = '';




  @override
  void initState() {
    quantityController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutBloc, CheckOutState>(
  listener: (context, state) {
    if (state is CheckOutSuccess) {
          if(state.cartItem != null){
            for (var element in widget.productList) {
              if(element.id.toString() ==  state.cartItem!.productId){
                quantity = state.cartItem!.quantity.toString();
                productPrice = state.cartItem!.amount.toString();
                element.prodDistributorPrice = state.cartItem!.amount.toString();
                element.isCart![0].quantity = state.cartItem!.quantity;
                element.isCart![0].productId = state.cartItem!.productId;
                element.isCart![0].amount = state.cartItem!.amount;
            }
            }
          }
          setState(() {});
        }
    if (state is CheckOutError) {
      snackBar(context, state.error);
      setState(() {});
    }
    },
  builder: (context, state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          itemCount: widget.productList.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 230),
          itemBuilder: (context, index) {
            Product product = widget.productList[index];
            prodMinQty =  product.prodMinDistrubutorQty ?? '';
            productPrice =  product.prodDistributorPrice??'';
            CartItem cartItem = CartItem();
            if(product.isCart!.isNotEmpty){
              cartItem.id = product.isCart?[0].id;
              cartItem.productId = product.isCart?[0].productId;
              cartItem.quantity = product.isCart?[0].quantity;
              cartItem.amount = product.isCart?[0].amount;
              productPrice = product.isCart?[0].amount.toString();
              productAddRemove = true;
            }


            return GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, productDetailRoute, arguments: ProductArgument(productId: product.id.toString(),product: product,distributorId: widget.distributorId));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: product.prodImageUrl.toString(),
                      fit: BoxFit.contain,
                      height: 126,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Space(
                      height: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyText(
                          text: product.prodName.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        NormalText(
                          text: product.prodShortDescription ?? '',
                          textSize: 12,
                          color: bodyLightBlack,
                        ),
                        BodyText(
                          text: rupeesSymbol + productPrice!,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widget.distributorId != null
                                ? product.isCart!.isEmpty
                                    ? BlocConsumer<ProductBloc, ProductState>(
                                        listener: (context, state) {
                                          if(state is CartProductLoading){
                                            cartLoading = true;
                                            setState(() {});
                                          }
                                          if(state is CartProductAddSuccess){
                                            cartLoading = false;
                                            cartProduct = state.cartProduct;
                                            if(selectedIndex == index){
                                              IsCart cartItem = IsCart();
                                              cartItem.id = cartProduct.id;
                                              cartItem.quantity = cartProduct.quantity;
                                              cartItem.amount = cartProduct.amount;
                                              product.isCart!.add(cartItem);
                                              productAddRemove = true;
                                              context.read<CheckOutBloc>().add(CartItemCountEvent());
                                              setState(() {});
                                            }
                                          }
                                          },

                                   builder: (context, state) {
                                          return product.id == productId && cartLoading ?
                                              const CustomProgressBar(widthV: 15,heightV: 15,) :
                                          product.id != productId ?
                                            AssetButton(
                                            image: cartIcon,
                                            padding: 0,
                                            onPressed: () {
                                              if(cartLoading == false){
                                                selectedIndex = index;
                                                setState(() => productId = product.id!);
                                                cartLoading = true;
                                                context.read<ProductBloc>().add(AddProductCartEvent(productId: product.id.toString()));
                                              }
                                            }) : Container();
                                            },
                                          )
                                : UpdateQuantityWidget(product : product,cartItem: cartItem,productName: product.prodName, quantity: cartItem.quantity!.toString(),distributorMinQty: prodMinQty, productAddRemove: productAddRemove,iconSize:24,textSize: 16,)
                                : Container()
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  },
);
  }



}

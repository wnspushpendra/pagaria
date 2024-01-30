import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/product_count.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class ProductList extends StatefulWidget {
  final List<Product> productList;
  final String from;

  const ProductList({required this.productList, super.key, required this.from});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController quantityController = TextEditingController();
  bool addItem = false;
  late int count;
  CartProduct cartProduct = CartProduct();
  int selectedIndex = -1;


  @override
  void initState() {
    quantityController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          itemCount: widget.productList.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 210),
          itemBuilder: (context, index) {
            Product product = widget.productList[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, productDetailRoute, arguments: widget.from);
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
                          text: product.prodShortDescription.toString(),
                          textSize: 12,
                          color: bodyLightBlack,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyText(
                              text: rupeesSymbol +
                                  product.prodDistributorPrice.toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            widget.from == 'create'
                                ? product.isCart!.isEmpty
                                    ? BlocConsumer<ProductBloc, ProductState>(
                                        listener: (context, state) {
                                          if(state is CartProductAddSuccess){
                                            cartProduct = state.cartProduct;
                                            if(selectedIndex == index){
                                              product.prodMinDistrubutorQty = cartProduct.quantity.toString();
                                              product.prodDistributorPrice = cartProduct.amount.toString();
                                              IsCart cart = IsCart();
                                              cart.id = cartProduct.id;
                                              cart.quantity = cartProduct.quantity.toString();
                                              cart.productId = cartProduct.productId.toString();
                                              product.isCart!.add(cart);
                                              print(product.isCart);
                                              setState(() {});
                                            }
                                          }
                                          },

                                   builder: (context, state) {
                                          return AssetButton(
                                            image: cartIcon,
                                            padding: 0,
                                            onPressed: () {
                                              selectedIndex = index;
                                              context.read<ProductBloc>().add(AddProductCartEvent(productId: product.id.toString()));
                                              });
                                            },
                                          )

                                : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Count(
                                              count: int.parse(product.prodMinDistrubutorQty!),
                                              onChange: (value) {
                                                setState(() {
                                                  count = value;
                                                  quantityController.text = count.toString();
                                                });
                                              }),
                                          SizedBox(
                                              height: 32,
                                              width: 28,
                                              child: IconButton(
                                                  onPressed: () =>
                                                      _quantityDialog(context,
                                                          'my product name'),
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    size: 20,
                                                    color: primaryColor,
                                                  ))),
                                        ],
                                      )
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
  }

  Future<void> _quantityDialog(BuildContext context, String productName) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          contentPadding: EdgeInsets.zero,
          content: Container(
              height: 215,
              //  color: bodyWhite,
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
                                  Navigator.of(context).pop();
                                })),
                        const Space(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: CustomButton(
                                buttonText: 'Ok',
                                buttonHeight: 40,
                                buttonTextSize: 14,
                                radius: 20,
                                margin: 0,
                                onClick: () {
                                  String qty = quantityController.text;
                                  setState(() => count = int.parse(qty));
                                  Navigator.of(context).pop();
                                })),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

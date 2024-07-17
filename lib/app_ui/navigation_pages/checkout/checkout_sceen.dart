import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/location.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/update_qty_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/bottom_sheet_delete_item.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/bottom_widget_checkout.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CheckOutScreen extends StatefulWidget {
  final User distributor;
//  final String distributorId;
  const CheckOutScreen({required this.distributor,super.key});

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
  bool showDelete = true,outOfStock = false;
  int? cartId;
  String prodMinQty = '';
  String userRole = '';
  LocationData? locationData;
  Placemark? placeMark;


  @override
  void initState() {
    super.initState();
    context.read<CheckOutBloc>().add(CheckOutListEvent());
    checkLocation();
  }

  checkLocation() async {

    locationData = await checkLocationPermission();
    placeMark = await getAddressFromLatLng(locationData!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => ChangeRoutes.openProductScreen(context, await getUser(), widget.distributor),
      child: Scaffold(
        appBar: appBarWidget(
            context,
            'Checkout',
            () async => ChangeRoutes.openProductScreen(context, await getUser(), widget.distributor)),
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
              ChangeRoutes.unAuthorizedError(context, state.error);
              checkOutLoading = false;
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
                          onPressed: () async => ChangeRoutes.openProductScreen(context, await getUser(), widget.distributor),/*Navigator.pushReplacementNamed(context, productRoute, arguments: 'create'),*/
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
                                  quantity = cartItem.quantity.toString();
                                  prodMinQty = (userRole == '4' ?  cartItem.productDetails!.prodMinDistrubutorQty! : cartItem.productDetails!.prodMinDistrubutorQty)!;

                                  if(cartItem.productDetails!.prodInventoryType! == "yes" && int.parse(cartItem.productDetails!.prodMinDistrubutorQty!) > int.parse(cartItem.productDetails!.availStock!)){
                                    outOfStock = true;
                                  }
                             /*     if(cartItem.productDetails!.prodInventoryType == "yes"){
                                    outOfStock =  int.parse(cartItem.productDetails!.availStock!) <= 0 ? true : false;
                                  }*/

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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
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
                                                        ChangeRoutes.unAuthorizedError(context, state.error);
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
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BodyText(
                                                    text: rupeesSymbol + cartItem.amount.toString(),
                                                    fontWeight: FontWeight.bold, color: primaryColor,),
                                                  outOfStock == true ?  BodyText(text: 'Out Of Stock',color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14.h,) :
                                                  UpdateQuantityWidget(product :cartItem.productDetails! ,cartItem: cartItem, productName : cartItem.productDetails!.prodName!,quantity: quantity!,distributorMinQty: prodMinQty, productAddRemove: productAddRemove)
                                                ],
                                              ),
                                            ],
                                          ),
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
                              child: CheckoutBottomWidget(totalCartAmount: productAmount,distributor : widget.distributor,locationData: locationData,placeMark: placeMark,)
                            )
                        ],
                      );
          },
        ),
      ),
    );
  }
}

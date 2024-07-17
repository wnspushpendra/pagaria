import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/update_qty_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/video_player/my_video_player.dart';
import 'package:webnsoft_solution/modal/argument_modal/ProductArgument.dart';
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_detail.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductArgument productArgument;

  const ProductDetailScreen({required this.productArgument, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool addToCart = false;
  bool productLoading = true;
  bool addToCartLoading = false;

  // ProductDetails product = ProductDetails();
  List<Productgallery> productGallery = [];
  CartProduct cartProduct = CartProduct();
  CartItem cartItem = CartItem();
  int selectedIndex = -1;
  String quantity = '';
  String productAmount = '';
  String itemPrice = '';
  bool? productAddRemove;
  String prodMinQty  = '';
  bool outOfStock = false;
  late FlickManager flickManager;
  bool showVideo = false;

  @override
  void initState() {
   initData();
    super.initState();
  }
  initData() async{
    var item = widget.productArgument.product;
    prodMinQty = item!.prodMinDistrubutorQty??'';
    quantity = item.prodMinDistrubutorQty??'';
    productAmount =  item.prodDistributorPrice ??'';
    if(item.isCart!.isNotEmpty){
      quantity = item.isCart![0].quantity!.toString();
      productAmount = item.isCart![0].amount.toString();
    }
    setState(() {});
  }


  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }




  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var product = widget.productArgument.product;
    if(product!.prodInventoryType! == "yes" && int.parse(product.prodMinDistrubutorQty!) > int.parse(product.availStock!)){
      outOfStock = true;
    }

    if (product.isCart != null && product.isCart!.isNotEmpty) {
      productAddRemove = true;
      cartItem.id = product.isCart![0].id;
      cartItem.quantity = int.parse(quantity); // this line need to cross verify
      cartItem.productId = product.isCart![0].productId;
    }

    return WillPopScope(
      onWillPop: () async{
        ChangeRoutes.openProductScreen(context,await getUser(), widget.productArgument.distributor );
       // Navigator.pushReplacementNamed(context, productRoute, arguments: widget.productArgument.distributorId)    ;
        return true;
      },
      child: Scaffold(
        appBar: appBarWidget(
            context,
            'Product Detail',
            () async =>  ChangeRoutes.openProductScreen(context,await getUser(), widget.productArgument.distributor)
        ),
        body: BlocConsumer<CheckOutBloc, CheckOutState>(
          listener: (context, state) {
            if (state is CheckOutSuccess) {
              if (state.cartItem != null) {
                quantity = state.cartItem!.quantity!.toString();
                productAmount = state.cartItem!.amount.toString();
                widget.productArgument.product!.prodDistributorPrice = state.cartItem!.amount.toString();
                widget.productArgument.product!.isCart![0].quantity = state.cartItem!.quantity;
                cartItem.quantity = state.cartItem!.quantity;
                cartItem.amount = state.cartItem!.amount;
              }
              setState(() {});
            }
            if (state is CheckOutError) {
              snackBar(context, state.error);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        SizedBox(
                            width: 70,
                            height: height * 0.25,
                            child: CachedNetworkImage(
                              imageUrl: product.prodImageUrl.toString(),
                              placeholder: (context, url) => Image.asset(
                                defaultImage,
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(defaultImage),
                            )),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: BodyText(
                                          text: product.prodName.toString(),
                                          align: TextAlign.start,
                                          fontSize: 22,
                                        ),
                                      ),
                                      BodyText(
                                        text: '$rupeesSymbol$productAmount',
                                        fontWeight: FontWeight.bold,),
                                    ],
                                  ),
                                  if(product.prodInventoryType == 'yes')
                                  BodyText(
                                    text: "Stock Quantity :  ${product.availStock}, Minimum Purchase Quantity : ${product.prodMinDistrubutorQty!}",
                                    fontSize: 14.h,
                                    color: outOfStock == true ? Colors.red : Colors.green,fontWeight: FontWeight.bold,
                                  ),
                                  const Space(height: 12,),
                                  BodyText(
                                    text: product.prodShortDescription ?? '',
                                    fontSize: 14.h,
                                    align: TextAlign.start,
                                  ),
                                  product.prodVideoUrl != null && product.prodVideoUrl!.isNotEmpty ?
                                  showVideo ? Container() : Container(
                                    margin: EdgeInsets.symmetric(vertical: 12.h),
                                    height : 220.h,
                                    width: 1.sw,
                                    child: Stack(
                                      children: [
                                        Blur(
                                            blur: 7,
                                            blurColor: Theme.of(context).primaryColor,
                                            child: CachedNetworkImage(imageUrl: product.prodImageUrl!,
                                              fit: BoxFit.cover,
                                              width: 1.sw,
                                            )
                                        ),
                                        Center(
                                          child: IconButton(onPressed: (){
                                            flickManager = FlickManager(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(product!.prodVideoUrl!)));
                                            showVideo = true;
                                            setState(() {});
                                          }, icon:  Icon(Icons.play_arrow,size: 44.h,)),
                                        )
                                      ],
                                    ),
                                  ) : Container(),
                                  showVideo ? Container(
                                      margin: EdgeInsets.only(top: 12.h,bottom: 12.h),
                                      height: 220,
                                      width: 1.sw,
                                      child: MyVideoPlayer(flickManager: flickManager,))
                                      : Container(),
                                  product.galleryImages!.isEmpty? Container()  : Stack(
                                    children: [
                                      Container(
                                        height: 140,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: product.galleryImages!.length  ,
                                            itemBuilder: (context, index) {
                                              var image = product.galleryImages![index];
                                              return GestureDetector(
                                                onTap: () => imageDialog( image.galleryImageUrl.toString(), context),
                                                child: SizedBox(
                                                  height: 120,
                                                  width: 120,
                                                  child: CachedNetworkImage(imageUrl: image.galleryImageUrl!),
                                                ),
                                              );
                                            }),
                                      ),

                                    ],
                                  ),
                                  Html(
                                    data: product.prodDescription ?? '',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Space(
                          height: 8,
                        ),
                        const Space(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                widget.productArgument.distributor == null
                    ? const SizedBox.shrink()
                    : Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: outOfStock == true ?  Container(
                          width: MediaQuery.of(context).size.width,
                            height: 40.h,
                            color: Colors.red,
                            alignment: Alignment.center,
                            child: BodyText(text: 'Out Of Stock',color: bodyWhite,fontWeight: FontWeight.bold,fontSize: 18.h,)) :
                        Container(
                          decoration: defaultDecoration,
                          child: product.isCart != null &&
                                  product.isCart!.isNotEmpty
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: UpdateQuantityWidget(
                                            product: widget.productArgument.product,
                                              cartItem: cartItem,
                                              quantity: quantity,
                                              distributorMinQty:
                                                  prodMinQty,
                                              productAddRemove: productAddRemove),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: CustomButton(
                                            buttonText: 'Checkout',
                                            margin: 0,
                                            radius: 0,
                                            buttonColor: Colors.green,
                                            onClick: () => Navigator.pushReplacementNamed(context, checkOutRoute,arguments: widget.productArgument.distributor!)
                                        ))
                                  ],
                                )
                              : BlocConsumer<ProductBloc, ProductState>(
                                  listener: (context, state) {
                                    if (state is CartProductAddSuccess) {
                                      cartProduct = state.cartProduct;
                                      quantity = cartProduct.quantity!.toString();
                                      productAmount = cartProduct.amount.toString();

                                      IsCart cart = IsCart();
                                      cart.id = cartProduct.id;
                                      cart.productId = cartProduct.productId;
                                      cart.quantity = cartProduct.quantity;
                                      cart.amount = cartProduct.amount;
                                      product.isCart!.add(cart);
                                      setState(() {});
                                    }
                                    if(state is ProductError) {
                                      addToCartLoading = false;
                                      setState(() {});
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                      buttonText: 'Add To Cart',
                                      showLoading: addToCartLoading,
                                      margin: 0,
                                      radius: 0,
                                      onClick: () {
                                        addToCartLoading = true;
                                        setState(() {});
                                        context.read<ProductBloc>().add(AddProductCartEvent(productId: product.id.toString()));
                                      },
                                    );
                                  },
                                ),
                        ))
              ],
            );
          },
        ),
      ),
    );
  }
  void imageDialog(String imageUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
       //   insetPadding: EdgeInsets.zero,
          backgroundColor: bodyWhite,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                width:MediaQuery.of(context).size.height*0.8 ,
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 8,
                  top: 8,
                  child: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close,size: 32,)))
            ],
          ),
        );
      },
    );
  }
}

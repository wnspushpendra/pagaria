import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/product_count.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_state.dart';
import 'package:webnsoft_solution/modal/product_detail.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailScreen extends StatefulWidget {
  final String from;

  const ProductDetailScreen({required this.from, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool addToCart = false;
  bool productLoading = false;
   ProductDetails productDetails = ProductDetails();
   List<Productgallery> productGallery = [];


  @override
  void initState() {
    context
        .read<ProductDetailsBloc>()
        .add(ProductDetailsLoadEvent(productId: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarWidget(
          context,
          'Product Detail',
          () => Navigator.pushReplacementNamed(context, productRoute,
              arguments: widget.from)),
      body: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
        listener: (context,productState){
          if(productState is ProductDetailsLoading){
            setState(() => productLoading = true );
          }
          if(productState is ProductDetailsSuccess){
            setState(() {
              productDetails = productState.productDetails;
              productGallery = productState.productGallery;
              print(productGallery);
            });
          }

        },
        builder: (context, productState) {
          if (productLoading) {
            return const Center(child: CustomProgressBar());
          } else {
            return Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      SizedBox(
                          width: 70,
                          height: height*0.25,
                          child: CachedNetworkImage(
                            imageUrl: productDetails.prodImageUrl.toString(),
                              placeholder: (context,url) => Image.asset(defaultImage,),
                              errorWidget: (context, url, error) => Image.asset(defaultImage),
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
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
                                       text:  productDetails.prodName.toString(),
                                         align: TextAlign.start,
                                       fontSize: 22,
                                     ),
                                   ),
                                   BodyText(
                                     text: '$rupeesSymbol${productDetails.prodDistributorPrice}',
                                     fontWeight: FontWeight.bold,
                                   ),

                                 ],
                               ),

                               BodyText(
                                 text:"Total Products Qty :  ${productDetails.prodInventory}",
                                 fontSize: 16,
                               ),
                               const Space(
                                 height: 12,
                               ),
                               BodyText(
                                 text:productDetails.prodShortDescription.toString(),
                                 fontSize: 16,
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 12),
                                 child: GridView.builder(
                                     shrinkWrap: true,
                                     physics: const NeverScrollableScrollPhysics(),
                                     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 160, mainAxisExtent: 120),
                                     itemCount: productGallery.length,
                                     itemBuilder: (context, index) {
                                       return CachedNetworkImage(imageUrl: productGallery[index].galleryImageUrl.toString());
                                     }),
                               ),

                               Html(
                                 data: productDetails.prodDescription.toString(),
                               )

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
              widget.from == 'product'
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: defaultDecoration,
                        child: addToCart
                            ? Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: Count(
                                              count: 1, onChange: (value) {}))),
                                  Expanded(
                                      flex: 1,
                                      child: CustomButton(
                                          buttonText: 'Payment',
                                          margin: 0,
                                          radius: 0,
                                          buttonColor: Colors.green,
                                          onClick: () {}))
                                ],
                              )
                            : CustomButton(
                                buttonText: 'Add To Cart',
                                margin: 0,
                                radius: 0,
                                onClick: () {
                                  setState(() {
                                    if (addToCart == true) {
                                      setState(() {
                                        addToCart = false;
                                      });
                                    } else {
                                      setState(() {
                                        addToCart = true;
                                      });
                                    }
                                  });
                                },
                              ),
                      ))
            ],
          );
          }
        },
      ),
    );
  }
}

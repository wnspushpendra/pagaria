import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_loading/shimmer_loading.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/product_count.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/widget/category/category.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/widget/product/product_list.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductScreen extends StatefulWidget {
  final String? distributorId;

  const ProductScreen(
      {/*required this.fromScreen,*/ this.distributorId, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool loadCategory = false;
  bool productLoading = false;

  List<Categories> categoryList = [];
  List<Categories> filterCategoryList = [];
  List<Product> productList = [];
  String userRole = '';
  List<Product> filterProductList = [];
  int selectedIndex = -1;
  bool activeButton = true;
   String itemCount = '';
  bool showCategory = true;
  String errorMessage = '';

  @override
  void initState() {
    context.read<CheckOutBloc>().add(CartItemCountEvent());
    context.read<CategoryBloc>().add(CategoryLoadEvent());
    super.initState();
  }

  void filteredCategoryList(String query) {
    setState(() {
      filterCategoryList = categoryList.where((category) {
        return category.catName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }
  void filteredProductList(String query) {
    setState(() {
      filterProductList = productList.where((contact) {
        return contact.prodName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: bodyWhite,
              ),
              onPressed: () async {
                User user = await getUser();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pushReplacementNamed(context,
                      user.roleId == '4' ? homeRoute : homeDistributorRoute,
                      arguments: user);
                });
              }),
          title: const BodyText(
            text: 'Product',
            color: bodyWhite,
          ),
          actions: [
            widget.distributorId != null
                ? BlocConsumer<CheckOutBloc, CheckOutState>(
              listener: (context,state){
                if(state is CheckOutSuccess){
                  if(state.cartItemCount != null){
                    itemCount = state.cartItemCount.toString();
                    setState(() {});
                  }
                }
              },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Stack(
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pushReplacementNamed(context, checkOutRoute, arguments: widget.distributorId),
                                icon: Image.asset(cartIcon, height: 30, color: bodyWhite,)),
                             Positioned(
                                right: 0,
                                child: BodyText(
                                  text: itemCount,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: bodyWhite,
                                )),
                          ],
                        ),
                      );
                    },
                  )
                : Container(),
            widget.distributorId == null ?
                 AssetButton(image: downloadLedger,color: bodyWhite, onPressed: () => snackBar(context, 'downloading catalog')) : Container()
          ],
        ),
        body: ListView(
          children: [
            const Space(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, height * 0.15, 0, 0),
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, productState) {
                      if (productState is ProductLoading) {
                        setState(() => productLoading = true);
                      }
                      if (productState is ProductSuccess) {
                        productLoading = false;
                        setState(() {
                          productList = productState.productList;
                          userRole = productState.userRole!;
                          filterProductList = productList;
                        });
                      }
                    },
                    builder: (context, state) {
                      return  productLoading
                          ? const CustomProgressBar(
                              heightV: 300,
                            )
                          : SizedBox(
                              height: height * 0.75,
                              child: ProductList(
                                userRole : userRole,
                                  productList: filterProductList,
                                  distributorId: widget.distributorId,
                              ),
                            );
                    },
                  ),
                ),
                BlocConsumer<CategoryBloc, CategoryState>(
                    listener: (context, categoryState) {
                  if (categoryState is CategoryLoading) {
                    setState(() => loadCategory = true);
                  }
                  if (categoryState is CategorySuccess) {
                    setState(() {
                      loadCategory = false;
                      categoryList = categoryState.categoryList;
                      if (categoryList.isNotEmpty) {
                        context.read<ProductBloc>().add(ProductLoadEvent(
                            categoryId: categoryList[0].id.toString()));
                      }
                    });
                  }
                  if (categoryState is CategoryError) {
                    errorMessage = categoryState.error;
                    loadCategory = false;
                    setState(() {});
                  }
                }, builder: (context, categoryState) {
                  return loadCategory
                      ? const CustomProgressBar()
                      : errorMessage.isNotEmpty ?  Container(
                    height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: BodyText(text: errorMessage,color: primaryColor,))  :
                  SizedBox(
                          height: height * 0.20,
                          child: Category(
                            categoryList: categoryList,
                            onClick: (String catId) => context
                                .read<ProductBloc>()
                                .add(ProductLoadEvent(categoryId: catId)),
                          ),
                        );
                }),
              ],
            ),
            const Space(
              height: 10,
            ),
            const Space(
              height: 40,
            ),
          ],
        ));
  }
}

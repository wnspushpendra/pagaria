import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/pdf/pdf_products.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/pdf/product_list_pdf.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_state.dart';
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
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductScreen extends StatefulWidget {
  // final String? distributorId;
  final User? distributor;

  const ProductScreen({this.distributor, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchProductController = TextEditingController();
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
   callApi();
    super.initState();
  }
   callApi(){
     context.read<CheckOutBloc>().add(CartItemCountEvent());
     context.read<CategoryBloc>().add(CategoryLoadEvent());
   }

  Future<void>   refresh() async{
    await callApi();
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        ChangeRoutes.openHomeScreen(context, await getUser());
      },

      child: RefreshIndicator(
        onRefresh: refresh,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: bodyWhite,
                  ),
                  onPressed: () async {
                    ChangeRoutes.openHomeScreen(context, await getUser());
                  }),
              title: const BodyText(
                text: 'Product',
                color: bodyWhite,
              ),
              actions: [
                // widget.user!.distributorId != null
                widget.distributor != null
                    ? BlocConsumer<CheckOutBloc, CheckOutState>(
                        listener: (context, state) {
                          if (state is CheckOutSuccess) {
                            if (state.cartItemCount != null) {
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
                                    onPressed: () =>
                                        ChangeRoutes.openCheckOutScreen(
                                            context, widget.distributor),
                                    /* Navigator.pushReplacementNamed(context, checkOutRoute, arguments: widget.distributorId*/
                                    icon: Image.asset(
                                      cartIcon,
                                      height: 30,
                                      color: bodyWhite,
                                    )),
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
                //   widget.distributorId == null
                widget.distributor == null
                    ? productList.isNotEmpty
                        ? AssetButton(
                            image: downloadLedger,
                            color: bodyWhite,
                            onPressed: () async {
                              snackBar(context, 'downloading product list data');
                              File pdfFile = await ProductsPdf()
                                  .generateProductPdf(productList);
                              saveAndOpenPdf(pdfFile);
                            })
                        : Container()
                    : Container()
              ],
            ),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.24),
                  height: height,
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
                      if (productState is ProductError) {
                        errorMessage = productState.error;
                        ChangeRoutes.unAuthorizedError(
                            context, productState.error);
                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      return productLoading
                          ? const CustomProgressBar(
                              heightV: 300,
                            )
                          : SingleChildScrollView(
                              child: ProductList(
                                userRole: userRole,
                                productList: filterProductList,
                                distributor: widget.distributor,
                                //  distributorId: widget.distributorId,
                              ),
                            );
                    },
                  ),
                ),
                Container(
                  height: height * 0.28.h,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.09,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomTextField(
                            hint: search,
                            label: search,
                            controller: searchProductController,
                            onTextChange: (value) => filteredProductList(searchProductController.text)),
                      ),
                      SizedBox(
                        height: height * 0.14,
                        child: BlocConsumer<CategoryBloc, CategoryState>(
                            listener: (context, categoryState) {
                          if (categoryState is CategoryLoading) {
                            setState(() => loadCategory = true);
                          }
                          if (categoryState is CategorySuccess) {
                            setState(() {
                              loadCategory = false;
                              categoryList = categoryState.categoryList;
                              categoryList.insert(
                                  0,
                                  Categories(
                                    id: 0,
                                    catName: 'Pagaria Products',
                                  ));
                              if (categoryList.isNotEmpty) {
                                context.read<ProductBloc>().add(ProductLoadEvent(categoryId: '0'));
                              }
                            });
                          }
                          if (categoryState is CategoryError) {
                            ChangeRoutes.unAuthorizedError(context, categoryState.error);
                            errorMessage = categoryState.error;
                            loadCategory = false;
                            setState(() {});
                          }
                        }, builder: (context, categoryState) {
                          return loadCategory
                              ? const CustomProgressBar()
                              : errorMessage.isNotEmpty
                                  ? Container(
                                      height: MediaQuery.of(context).size.height,
                                      alignment: Alignment.center,
                                      child: BodyText(
                                        text: errorMessage,
                                        color: primaryColor,
                                      ))
                                  : SizedBox(
                                      height: height * 0.20,
                                      child: Category(
                                        categoryList: categoryList,
                                        onClick: (String catId) => context
                                            .read<ProductBloc>().add(ProductLoadEvent(categoryId: catId)),
                                      ),
                                    );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

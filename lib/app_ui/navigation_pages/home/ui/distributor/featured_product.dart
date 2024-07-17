
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/single_child_widget.dart';
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

class FeaturedProductScreen extends StatefulWidget {
  const FeaturedProductScreen({ super.key});

  @override
  State<FeaturedProductScreen> createState() => _FeaturedProductScreenState();
}

class _FeaturedProductScreenState extends State<FeaturedProductScreen> {
  TextEditingController searchProductController = TextEditingController();
  bool productLoading = false;
  List<Product> productList = [];
  String userRole = '';
  List<Product> filterProductList = [];
  int selectedIndex = -1;
  bool activeButton = true;
  String itemCount = '';
  String errorMessage = '';
  List<Product> recentProducts = [];


  @override
  void initState() {
   callApi();
    super.initState();
  }
   callApi(){
     context.read<CheckOutBloc>().add(CartItemCountEvent());
     context.read<ProductBloc>().add(ProductLoadEvent(categoryId: '0'));
   }

   Future<void> onRefresh() async {
    await callApi();
   }

  void filteredProductList(String query) {
    setState(() {
      filterProductList = recentProducts.where((contact) {
        return contact.prodName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  latestProductList(){
    DateTime today = DateTime.now();
    for (Product product in productList) {
      Duration difference = today.difference(DateTime.parse(product.createdAt!));
      if (difference.inDays <= 30) {
        recentProducts.add(product);
      }
    }
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
        onRefresh: onRefresh,
        child: Scaffold(
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.10),
                  height: height,
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, productState) {
                      if (productState is ProductLoading) {
                        setState(() => productLoading = true);
                      }
                      if (productState is ProductSuccess) {
                        productLoading = false;
                        productList = productState.productList;
                        latestProductList();
                        userRole = productState.userRole!;
                        filterProductList = recentProducts;
                        setState(() {});
                      }
                      if (productState is ProductError) {
                        errorMessage = productState.error;
                        ChangeRoutes.unAuthorizedError(context, productState.error);
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
                                distributor: null,
                                  showNewIcon : true
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
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/list_grid_buttons.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/category_list.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/grid_list/grid_listview_product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/linear_list/linear_listview_product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_category_item.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_list_item.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> categoryList = [];
  List<String> productList = [
    'Machine',
    'Mouse',
    'Desktop',
    'Keyboard',
    'Ram',
    'Mouse',
    'Desktop',
    'Keyboard',
    'Ram'
  ];  int selectedIndex = -1;
  bool activeButton = true;
  late int count;
  bool addItem = false;
  bool showCategory = true;

  addCategories() {
    categoryList.add('Repairing');
    categoryList.add('Menufacturing');
    categoryList.add('Chocolate');
    categoryList.add('Biscuit');
    categoryList.add('Driving');
  }

  @override
  void initState() {
    addCategories();
    //  context.read<CategoryBloc>().add(CategoryLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, 'Create Order',
                () => onPopReplace(context, navigationRoute)),
        body: Stack(children: <Widget>[


          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if(state is ProductSuccess){
                productList = state.productList;
              }
              return Container(
                padding:  EdgeInsets.fromLTRB(showCategory ? 100.h:0, 68, 0, 0),
                margin: EdgeInsets.symmetric(horizontal: 6.h),
                child:  ListView(
                  shrinkWrap: true,
                  children: [
                    activeButton
                        ? LinearListViewProduct(
                      productList: productList,
                      selectedProduct: (List<String> value) {
                      },
                    )
                        : GridListViewProduct(
                      productList: productList,
                      selectedProduct: (List<String> value) {

                      },
                    ),
                    const Space(height: 120,)
                  ],
                ),
              );
            },
          ),

          Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !showCategory
                        ? SizedBox(
                      width: 40.h,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              showCategory = true;
                              activeButton = true;
                            });
                          },
                          icon: Icon(activeButton
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.arrow_back_ios_new)),
                    )
                        :  BlocConsumer<CategoryBloc, CategoryState>(
                      listener: (context, state) {
                        if (state is CategorySuccess) {
                          context.read<ProductBloc>().add(ProductLoadEvent());
                        }
                      },
                      builder: (context, state) {
                        if (state is CategorySuccess) {
                          categoryList = state.categoryList;
                        }
                        return  SizedBox(
                          width: 100,
                          height: MediaQuery.of(context).size.height.h,
                          child: CategoryList(
                            categoryList: categoryList,
                          ),
                        );
                      },
                    ),

                    Expanded(
                      flex: 5,
                      child: ListGridButton(
                          activeButton: activeButton,
                          onChange: (value) {
                            setState(() {
                              activeButton = value;
                              if (!activeButton) {
                                showCategory = false;
                              } else {
                                showCategory = true;
                              }
                            });
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),

        ]));


    /*Scaffold(
      appBar: appBarWidget(
          context, "Product", () => onPopReplace(context, homeRoute)),
      body: Column(
        children: [
          BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategorySuccess) {
                context.read<ProductBloc>().add(ProductLoadEvent());
              }
            },
            builder: (context, state) {
              if (state is CategorySuccess) {
                categoryList = state.categoryList;
              }
              return SizedBox(
                height: 60,
                child: ListView.builder(
                    itemCount: categoryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var color = selectedIndex == index
                          ? Colors.green
                          : primaryColor;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                        child: ProductCategoryListItem(
                          category: categoryList[index],
                          color: color,
                        ),
                      );
                    }),
              );
            },
          ),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if(state is ProductSuccess){
                productList = state.productList;
              }
              setState(() {});
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, state) {
                      return const ProductListItem(
                        category: 'abc',
                        productName: 'cald break tea',
                        price: '500000',
                        quantity: '4444',
                        image: networkImage,
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );*/
  }
}

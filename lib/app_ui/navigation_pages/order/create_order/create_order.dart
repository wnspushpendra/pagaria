import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/bottom_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/grid_list/grid_listview_product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/linear_list/linear_listview_product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/category_list.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/list_grid_buttons.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController searchController = TextEditingController();
  List<Categories> categoryList = [];
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
  ];

  List<String> userSelectedProducts = [];

  bool activeButton = true;
  late int count;
  bool addItem = false;
  bool showCategory = true;


  @override
  void initState() {
    //  context.read<CategoryBloc>().add(CategoryLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, 'Create Order',
            () async => Navigator.pushReplacementNamed(context, homeRoute,arguments: await getUser())),
        body: Stack(children: <Widget>[
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if(state is ProductSuccess){
              //  productList = state.productList;
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
                      from: 'create',
                      selectedProduct: (List<String> value) {
                      },
                    )
                        : GridListViewProduct(
                      productList: productList,
                      from: 'create',
                      selectedProduct: (List<String> value) => print(value),
                    ),
                    const Space(height: 120,)
                  ],
                ),
              );
            },
          ),
          BottomWidget(selectedProduct: userSelectedProducts, onClick: () => showSheet()),
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
                          //context.read<ProductBloc>().add(ProductLoadEvent());
                        }
                      },
                      builder: (context, state) {
                        if (state is CategorySuccess) {
                          categoryList = state.categoryList;
                        }
                        return  SizedBox(
                          width: 100,
                          height: MediaQuery.of(context).size.height.h,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: BodyText(text: 'Category',fontWeight: FontWeight.bold,fontSize: 14,),
                              ),
                              CategoryList(
                                categoryList: [],
                              ),
                            ],
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
  }

  /// ************** bottom sheet for filters **********************

  void showSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.55,
                    padding: const EdgeInsets.all(16),
                    // margin: const EdgeInsets.symmetric(horizontal: 12),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2),
                        ]),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        const Space(
                          height: 10,
                        ),
                        const HeadingText(
                          text: 'Selected Product',
                          color: primaryColor,
                        ),
                        const Space(
                          height: 8,
                        ),
                        ListView.builder(
                            itemCount: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.fromLTRB(2, 8, 4, 2),
                                decoration: defaultDecoration,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://pbs.twimg.com/profile_images/1075240418936160256/BYPSMMdz_400x400.jpg",
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                        const Space(
                                          width: 8,
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  BodyText(
                                                    text: "abc ",
                                                    fontSize: 16,
                                                  ),
                                                  BodyText(
                                                    text: "Category ",
                                                    fontSize: 16,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  BodyText(
                                                    text: "Quantity ",
                                                    fontSize: 16,
                                                  ),
                                                  BodyText(
                                                    text: "10",
                                                    fontSize: 16,
                                                    color: primaryColor,
                                                    align: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const Space(
                          height: 8,
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                              buttonText: 'Place Order',
                              buttonTextSize: 11,
                              buttonHeight: 40,
                              buttonColor: Colors.green,
                              radius: 0,
                              margin: 0,
                              onClick: () {}),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                              buttonText: 'Cancel',
                              buttonTextSize: 11,
                              buttonHeight: 40,
                              margin: 0,
                              radius: 0,
                              onClick: () {
                                setState(() {
                                  Navigator.pop(context);
                                  //  Navigator.of(context).pop();
                                  //   Navigator.of(context).pop();
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

/*  get listviewWidget => Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: productList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return  CreateOrderProductListItem(
                  category: 'abc',
                  productName: productList[index].toString(),
                  quantity: '10',
                  date: '10-12-2023');
            }),
      );*/

/*  get getGridViewWidget => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 95,
      ),
      shrinkWrap: true,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          decoration: defaultDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(6, 6, 4, 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://pbs.twimg.com/profile_images/1075240418936160256/BYPSMMdz_400x400.jpg",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                   Expanded(
                      flex: 3,
                      child: BodyText(text: productList[index].toString(), fontSize: 14))
                ],
              ),
              addItem
                  ? Count(
                      count: count,
                      onChange: (int value) {
                        setState(() {
                          count = value;
                          if (value == 0) {
                            addItem = false;
                          }
                        });
                      },
                    )
                  : CustomButton(
                      buttonText: 'Add',
                      buttonTextSize: 14,
                      buttonTextColor: bodyWhite,
                      padding: 0,
                      radius: 45,
                      buttonWidth: 90,
                      buttonHeight: 30,
                      onClick: () => setState(() {
                            addItem = true;
                            count = 1;
                          }))
            ],
          ),
        );
      });*/
}

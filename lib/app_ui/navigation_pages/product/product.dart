import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/list_grid_buttons.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/product_count.dart';
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
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _controller = ScrollController();

  List<String> categoryList = [];
  List<String> productList = ['Machine', 'Mouse', 'Desktop', 'Keyboard', 'Ram', 'Mouse', 'Desktop', 'Keyboard', 'Ram'];
  int selectedIndex = -1;
  bool activeButton = true;
  late int count;
  bool addItem = false;
  bool showCategory = true;
  TextEditingController quantityController = TextEditingController();

  addCategories() {
    categoryList.add('Repairing');
    categoryList.add('Manufacturing');
    categoryList.add('Chocolate');
    categoryList.add('Biscuit');
    categoryList.add('Driving');
    categoryList.add('Driving');
    categoryList.add('abc');
  }

  @override
  void initState() {
    addCategories();
    quantityController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, 'Product List',
                () async{
              User? user = await getUserPref(userProfileDataPrefecences);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
              });
            }),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Space(height: 10,),
          Stack(
            children: [
              SizedBox(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context,index){
                      return  Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.fromLTRB(0,0,0,4),
                        decoration: BoxDecoration(
                          color: bodyWhite,
                          border: Border.all(width: 0.5,color: bodyLightBlack),
                          borderRadius: const BorderRadius.all(Radius.circular(4))
                        ),
                        child: Column(
                          children: [
                            Image.network(productImage,height: 88,),
                            const Space(height: 2,),
                            BodyText(text: categoryList[index],fontSize: 12,)
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                   moveToPreviousItem();
                    }, icon: const Icon(Icons.arrow_back_ios_new)),
                  IconButton(onPressed: (){
                    moveToNextItem();
                  }, icon: const Icon(Icons.arrow_forward_ios_outlined)),
                ],
              )


            ],
          ),
          const Space(height: 10,),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              itemCount: productList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                  mainAxisExtent: 210
                ),
                itemBuilder: (context,index){
                  return Container(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1,color: Colors.black12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(productImage1,
                          fit: BoxFit.contain,
                          height: 126,width: MediaQuery.of(context).size.width,),
                        const Space(height: 4,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BodyText(text: productList[index],fontSize: 14,fontWeight: FontWeight.bold,),
                            const NormalText(text: 'this is product short description awailable here',textSize: 12,color: bodyLightBlack,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                const BodyText(text: '${rupeesSymbol}12330',fontWeight: FontWeight.bold,fontSize: 14,),
                                !addItem? AssetButton(image: cartIcon,
                                   padding: 0,
                                   onPressed: (){
                                   setState(() {
                                     count = 1;
                                     quantityController.text = count.toString();
                                     addItem = true;
                                   });
                                   },) :
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Count(count: count, onChange: (value){
                                       setState(() {
                                         count = value;
                                         quantityController.text = count.toString();
                                       });
                                     }),
                                     SizedBox(
                                         height : 32,
                                         width : 28,child: IconButton(onPressed: () => _quantityDialog(context, 'my product name'), icon: const Icon(Icons.edit,size: 20,color: primaryColor,))),
                                   ],
                                 )
                              ],

                             )
                          ],
                        )

                      ],
                    ),
                  );
                }),
          ),
          const Space(height: 40,),

        ],
      )
    );

   /* return Scaffold(
        appBar: appBarWidget(context, 'Product List',
                () async{
      User? user = await getUserPref(userProfileDataPrefecences);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
      });
    }),
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
                      from: 'product',
                      selectedProduct: (List<String> value) {
                      },
                    )
                        : GridListViewProduct(
                      productList: productList,
                      from: 'product',
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

        ]));*/

  }

  Future<void> _quantityDialog(BuildContext context,String productName) async {
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
                  CustomTextField(controller: quantityController,
                    maxLength: 4,
                    inputFormatter: InputFieldFormatter.numberFormat,
                    hint: 'Quantity', label: 'Quantity',
                    onTextChange: (bool value) {  },),
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CustomButton(buttonText: 'Cancel',
                                buttonHeight: 40,
                                buttonTextSize: 14,
                                radius: 20,
                                margin: 0,
                                onClick: (){
                              Navigator.of(context).pop();
                                })),
                        const Space(width: 10,),
                        Expanded(
                            flex: 1,
                            child: CustomButton(buttonText: 'Ok',
                                buttonHeight: 40,
                                buttonTextSize: 14,
                                radius: 20,
                                margin: 0,
                                onClick: (){
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

  void moveToNextItem() {
    _controller.animateTo(
      _controller.offset + 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void moveToPreviousItem() {
    _controller.animateTo(
      _controller.offset - 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

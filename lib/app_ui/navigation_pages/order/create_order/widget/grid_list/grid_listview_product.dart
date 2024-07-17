import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/grid_list/grid_list_item.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';

class GridListViewProduct extends StatelessWidget {
  final List<String> productList;
  final String? from;
  ValueChanged<List<String>> selectedProduct;

  GridListViewProduct({required this.productList, this.from,required this.selectedProduct,super.key});
  late int count;
  bool addItem = false;
  List<String> selectedUserProductList = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 165.h
        ),
        shrinkWrap: true,
        itemCount: productList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, productDetailRoute,arguments:  from );
            },
            child: GridListItem(category: '', productName: productList[index],from: from,
                updateQuantity: (value){
                  if(value == 0){
                    selectedUserProductList.remove(productList[index]);
                    selectedProduct(selectedUserProductList);
                  }else{
                    selectedUserProductList.add(productList[index]);
                    selectedProduct(selectedUserProductList);
                  }
                }),
          );
        });
  }
}

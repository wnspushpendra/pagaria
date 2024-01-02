import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/grid_list/grid_list_item.dart';

class GridListViewProduct extends StatefulWidget {
  final List<String> productList;
  ValueChanged<List<String>> selectedProduct;

  GridListViewProduct({required this.productList,required this.selectedProduct,super.key});

  @override
  State<GridListViewProduct> createState() => _GridListViewProductState();
}

class _GridListViewProductState extends State<GridListViewProduct> {
  late int count;
  bool addItem = false;
  List<String> selectedUserProductList = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: widget.productList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GridListItem(category: '', productName: widget.productList[index],
              updateQuantity: (value){
                if(value == 0){
                  selectedUserProductList.remove(widget.productList[index]);
                  widget.selectedProduct(selectedUserProductList);
                }else{
                  selectedUserProductList.add(widget.productList[index]);
                  widget.selectedProduct(selectedUserProductList);
                }
              });
        });
  }
}

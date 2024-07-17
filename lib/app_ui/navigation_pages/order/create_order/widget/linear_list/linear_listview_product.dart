import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/linear_list/list_item.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';


class LinearListViewProduct extends StatefulWidget {
  final List<String> productList;
  final String? from;
  ValueChanged<List<String>> selectedProduct;

  LinearListViewProduct({required this.productList, this.from,required this.selectedProduct,super.key});

  @override
  State<LinearListViewProduct> createState() => _LinearListViewProductState();
}

class _LinearListViewProductState extends State<LinearListViewProduct> {
  int selectedIndex = 0;
  bool addItem = false;
  late int count;
  List<String> selectedUserProductList = [];



  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        shrinkWrap: true,
        itemCount: widget.productList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, productDetailRoute,arguments: widget.from );
            },
            child: ListItem(category: '', productName: widget.productList[index],from : widget.from,
                updateQuantity: (value){
              if(value == 0){
                selectedUserProductList.remove(widget.productList[index]);
                widget.selectedProduct(selectedUserProductList);
              }else{
                selectedUserProductList.add(widget.productList[index]);
                widget.selectedProduct(selectedUserProductList);
              }
            }
            ),
          );
        });
  }
}

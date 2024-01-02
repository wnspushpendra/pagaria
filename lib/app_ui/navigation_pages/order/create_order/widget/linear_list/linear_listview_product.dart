import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/widget/linear_list/list_item.dart';


class LinearListViewProduct extends StatefulWidget {
  List<String> productList;
  ValueChanged<List<String>> selectedProduct;

  LinearListViewProduct({required this.productList,required this.selectedProduct,super.key});

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
          return ListItem(category: '', productName: widget.productList[index],
              updateQuantity: (value){
            if(value == 0){
              selectedUserProductList.remove(widget.productList[index]);
              widget.selectedProduct(selectedUserProductList);
            }else{
              selectedUserProductList.add(widget.productList[index]);
              widget.selectedProduct(selectedUserProductList);
            }

              }
          );

          /*return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(2, 8, 4, 2),
            decoration: defaultDecoration,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: "https://pbs.twimg.com/profile_images/1075240418936160256/BYPSMMdz_400x400.jpg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const Space(width: 8,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          BodyText(
                            text: widget.productList[index], fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                    addItem ? Count(count: count, onChange: (int value) {
                      if(selectedIndex == index){
                        setState(() {
                          count = value;
                          widget.addRemoveItemChange(count.toString());
                          if (value == 0) {
                            addItem = false;
                          }
                        });
                      }
                      },) :
                    CustomButton(
                        buttonText: 'Add',
                        buttonTextSize: 14,
                        buttonTextColor: bodyWhite,
                        padding: 0,
                        radius: 45,
                        buttonWidth: 90,
                        buttonHeight: 30,
                        onClick: () =>
                            setState(() {
                              selectedIndex = index;
                              addItem = true;
                              count = 1;
                            })
                    )
                  ],
                ),

              ],
            ),
          );*/
        });
  }
}

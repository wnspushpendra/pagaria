import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/update_product_qty.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class UpdateQuantityWidget extends StatefulWidget {
  final CartItem cartItem;
  final String quantity;
  bool? productAddRemove;

  UpdateQuantityWidget({required this.cartItem,required this.quantity, required this.productAddRemove,super.key});

  @override
  State<UpdateQuantityWidget> createState() => _UpdateQuantityWidgetState();
}

class _UpdateQuantityWidgetState extends State<UpdateQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => updateQty('remove',widget.cartItem),
                  icon: const Icon(
                    Icons.remove_circle,
                    color: primaryColor,
                    size: 28,
                  )),
              BodyText(
                text: widget.quantity,
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
              IconButton(
                  padding:
                  const EdgeInsets
                      .all(0),
                  onPressed: () => updateQty('add',widget.cartItem),
                  icon: const Icon(
                    Icons.add_circle_outlined,
                    color: primaryColor,
                    size: 28,
                  )),
            ],
          ),
          SizedBox(
            width: 30,height: 30,
            child: AssetButton(image: edit,
              onPressed: () {
                Future<String?> futureQty = quantityDialog(context, widget.cartItem);

              },),
          )
        ],
      ),
    );
  }
  updateQty(String from,CartItem item) {
    var qty;
    if(from == 'add'){
      widget.productAddRemove = true;
      qty = '${int.parse(item.quantity!)+1}';
      context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));
      /*  if(int.parse(item.productDetails!.prodInventory!) < qty){
      }*/
    }else{
      widget.productAddRemove = false;
      if(int.parse(item.quantity!) != 1 ){
        qty = int.parse(item.quantity!)-1;
      }
      if(int.parse(item.productDetails!.prodMinDistrubutorQty!)  <=  qty){
        context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));
      }else{
        snackBar(context, 'You can order minimum ${item.productDetails!.prodMinDistrubutorQty} for this item');
      }
    }


  }

}

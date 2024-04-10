import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/update_product_qty.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class UpdateQuantityWidget extends StatefulWidget {
  final Product? product;
  final CartItem cartItem;
  final String? productName;
  final String quantity;
  final String? distributorMinQty;
  bool? productAddRemove;
  double? iconSize;
  double? textSize;

  UpdateQuantityWidget({this.product,required this.cartItem,this.productName,required this.quantity,this.distributorMinQty, required this.productAddRemove,this.iconSize,this.textSize,super.key});

  @override
  State<UpdateQuantityWidget> createState() => _UpdateQuantityWidgetState();
}

class _UpdateQuantityWidgetState extends State<UpdateQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.iconSize != null  ? 32 :36,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => updateQty('remove',widget.cartItem),
                  icon:  Icon(
                    Icons.remove_circle,
                    color: primaryColor,
                    size: widget.iconSize ?? 28,
                  )),
              GestureDetector(
                onTap: () => quantityDialog(context, widget.cartItem,widget.product!,widget.distributorMinQty!),
                child: BodyText(
                  text: widget.quantity,
                  fontSize: widget.iconSize ?? 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => updateQty('add',widget.cartItem),
                  icon:  Icon(
                    Icons.add_circle_outlined,
                    color: primaryColor,
                    size: widget.iconSize ?? 28
                  )),
            ],
          ),
        ],
      ),
    );
  }
  updateQty(String from,CartItem item) async {
    var qty;
    if(from == 'add'){
      qty = '${item.quantity!+1}';
      if (widget.product!.prodInventoryType == 'yes') {
        if (int.parse(widget.product!.availStock!) >= int.parse(qty)) {
          if (int.parse(widget.distributorMinQty!) <= int.parse(qty)) {
            context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty: qty, cartItemId: item.id.toString()));
          } else {
            snackBar(context, 'you can create min ${widget.distributorMinQty} quantity');
          }
        } else {
          snackBar(context, '${widget.product!.prodName} ${widget.product!.availStock} quantity available in stock.');
        }
      } else {
        if (int.parse(widget.distributorMinQty!) <= int.parse(qty)) {
          context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty: qty.toString(), cartItemId: item.id.toString()));
        } else {
          snackBar(context, 'you can create min ${widget.distributorMinQty} quantity');
        }
      }



    //  context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));

    }else{
      String minimumQty;
      qty = '${item.quantity!-1}';
      minimumQty = widget.distributorMinQty!;

      if(int.parse(minimumQty)  <=  int.parse(qty)){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));
        });
      }else{
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          snackBar(context, 'You can order minimum $minimumQty for this item');
        });
      }
    }

  }

}

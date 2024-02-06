import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/update_product_qty.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class UpdateQuantityWidget extends StatefulWidget {
  final CartItem cartItem;
  final String? productName;
  final String quantity;
  final String? distributorMinQty;
  bool? productAddRemove;
  double? iconSize;
  double? textSize;


  UpdateQuantityWidget({required this.cartItem,this.productName,required this.quantity,this.distributorMinQty, required this.productAddRemove,this.iconSize,this.textSize,super.key});

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
                onTap: () => quantityDialog(context, widget.cartItem,widget.productName!,widget.distributorMinQty!),
                child: BodyText(
                  text: widget.quantity,
                  fontSize: widget.iconSize ?? 20,
                  fontWeight:
                  FontWeight.bold,
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
         /* SizedBox(
            width: 30,height:30,
            child: AssetButton(image: edit,
              onPressed: () {
                Future<String?> futureQty = quantityDialog(context, widget.cartItem);
 },),
          )*/
        ],
      ),
    );
  }
  updateQty(String from,CartItem item) async {
    var qty;
    if(from == 'add'){
      qty = '${int.parse(item.quantity!)+1}';
      context.read<CheckOutBloc>().add(CheckOutUpdateQuantityEvent(productQty:qty.toString() , cartItemId: item.id.toString(), ));

    }else{
      User user = await getUser();
      String minimumQty;
      qty = '${int.parse(item.quantity!)-1}';
      if(user.roleId == '4') {
        minimumQty = widget.distributorMinQty!;
        //  minimumQty = widget.distributorMinQty == null ? item.productDetails!.prodMinDistrubutorQty! : widget.distributorMinQty!;
      }else{
        minimumQty = widget.distributorMinQty!;

      }

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

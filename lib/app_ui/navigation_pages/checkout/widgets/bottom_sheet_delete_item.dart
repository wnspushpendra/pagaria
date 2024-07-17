import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class DeleteProductBottomSheet extends StatefulWidget {
  final CartItem cartItem;
  final ValueChanged<int> cartItemId;

  const DeleteProductBottomSheet({super.key, required this.cartItem, required this.cartItemId});

  @override
  State<DeleteProductBottomSheet> createState() => _DeleteProductBottomSheetState();
}

class _DeleteProductBottomSheetState extends State<DeleteProductBottomSheet> {
  bool itemRemoveLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const BodyText(
                text: 'Remove Item',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          const Space(
            height: 8,
          ),
          BodyText(
            text: widget.cartItem.productDetails!.prodName!,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          const Space(
            height: 8,
          ),
          const Divider(
            height: 1,
            color: bodyLightBlack,
          ),
          const Space(
            height: 8,
          ),
          BodyText(
            text:
                'Are you sure want to delete ${widget.cartItem.productDetails!.prodName!} contain with  ${widget.cartItem.quantity} quantity and amount $rupeesSymbol${widget.cartItem.amount}?',
            fontSize: 16,
            align: TextAlign.start,
          ),
          const Space(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context,state){
                      if(state is CartProductRemoveLoading){
                        itemRemoveLoading = true;
                        setState(() {});
                      }
                      if(state is CartProductRemoveSuccess){
                        itemRemoveLoading = false;
                        Navigator.of(context).pop();
                        setState(() {});

                      }
                      if(state is ProductError){
                        itemRemoveLoading = false;
                        snackBar(context, state.error);
                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                          buttonText: 'Yes',
                          radius: 8,
                          buttonHeight: 50.h,
                          showLoading: itemRemoveLoading,
                          onClick: () {
                            itemRemoveLoading = true;
                            setState(() {});
                            context.read<ProductBloc>().add(RemoveProductCartEvent(cartItemId: widget.cartItem.id.toString()));
                          });
                    },
                  )),
              const Space(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: CustomButton(
                      buttonText: 'No',
                      buttonColor: bodyWhite,
                      radius: 8,
                      buttonTextColor: bodyBlack,
                      borderColor: primaryColor,
                      buttonHeight: 50.h,
                      onClick: () => Navigator.of(context).pop())),
            ],
          ),
        ],
      ),
    );
  }
}

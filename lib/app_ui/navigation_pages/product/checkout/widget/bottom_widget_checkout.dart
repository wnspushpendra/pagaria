import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CheckoutBottomWidget extends StatefulWidget {
  final String distributorId;
  final String totalCartAmount;

  const CheckoutBottomWidget({required this.distributorId,  required this.totalCartAmount, super.key});

  @override
  State<CheckoutBottomWidget> createState() => _CheckoutBottomWidgetState();
}

class _CheckoutBottomWidgetState extends State<CheckoutBottomWidget> {
  bool orderPlaceLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if(state is OrderLoading){
       setState(() => orderPlaceLoading = true);
        }
        if(state is OrderSuccess){
          Navigator.pushReplacementNamed(context, orderRoute,arguments: true);
        }
        if(state is OrderError){
          snackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Container(
          decoration: defaultDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 6),
                child: BodyText(
                  text:
                  'Cart Amount : $rupeesSymbol${widget.totalCartAmount}',
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomButton(
                buttonText: 'Place Order',
                radius: 0,
                margin: 0,
                showLoading: orderPlaceLoading,
                onClick: () =>
                    context.read<OrderBloc>().add(
                        OrderSubmitEvent(distributorId : widget.distributorId,totalAmount: widget.totalCartAmount)),
              ),
            ],
          ),
        );
      },
    );
  }
}

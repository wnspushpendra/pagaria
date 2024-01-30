import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class OrderScreen extends StatefulWidget {
  final bool? showAppbar;
  final String? distributorId;

  const OrderScreen({this.showAppbar,this.distributorId, super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool loadOrder = true;
  List<OrderList> orderList = [];

  @override
  void initState() {
    context.read<OrderBloc>().add(OrderListFetchEvent( distributorId: widget.distributorId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.showAppbar == true
          ? appBarWidget(context, 'Order ',() async => Navigator.pushReplacementNamed(context, homeRoute, arguments: await getUser()))
          : null,
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if(state is OrderSuccess){
            if(state.orderList != null){
              loadOrder = !loadOrder;
              orderList = state.orderList!;
              setState(() {});
            }
          }
          if(state is OrderError){
            loadOrder = false;
            setState(() => snackBar(context, state.error ) );
          }
        },
        builder: (context, state) {
          return loadOrder ? const Center(
            child: CustomProgressBar(),
          ) :
          Container(
            padding: EdgeInsets.all(12.h),
            child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  OrderList order = orderList[index];

                  return Container(
                    padding: EdgeInsets.all(12.h),
                    margin: EdgeInsets.fromLTRB(2.h, 5.h, 2.h, 5.h),
                    decoration: defaultDecoration,
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: customerName,
                                  fontSize: 16.h,
                                ),
                                 BodyText(
                                  text: order.userData!.fullName!,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: email,
                                  fontSize: 16.h,
                                ),
                                 BodyText(
                                  text: order.userData!.email!,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          )
                        ]),
                        Space(
                          height: 8.h,
                        ),
                        Row(children: [
                           Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BodyText(
                                  text: 'Total Price',
                                ),
                                BodyText(
                                  text: order.totalAmount ?? '',
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                                buttonText: 'Detail',
                                buttonTextSize: 14,
                                buttonWidth: 96,
                                buttonHeight: 40,
                                margin: 0,
                                radius: 20,
                                onClick: () => Navigator.pushReplacementNamed(context, orderDetailRoute,arguments: order)),
                          )
                        ]),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}

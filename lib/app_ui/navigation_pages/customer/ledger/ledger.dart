import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class LedgerScreen extends StatefulWidget {
  // final String distributorId;
  final LedgerArgument argument;

  const LedgerScreen({required this.argument, super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  bool loadOrder = true;
  List<OrderList> orderList = [];
  List<OrderProduct> productList = [];

  @override
  void initState() {
    context
        .read<OrderBloc>()
        .add(OrderListFetchEvent(distributorId: widget.argument.distributorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.argument.showAppbar == null
          ? null
          : appBarWidget(context, 'Ledger',
              () => Navigator.pushReplacementNamed(context, customerRoute)),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            loadOrder = false;
            if (state.orderList != null) {
              orderList = state.orderList!;
            }
            setState(() {});
          }
          if (state is OrderError) {
            loadOrder = false;
            setState(() => snackBar(context, state.error));
          }
        },
        builder: (context, state) {
          return loadOrder
              ? const Center(
                  child: CustomProgressBar(),
                )
              : Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                    child: Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            print(orderList.length);
                            OrderList order = orderList[index];
                            productList = (json.decode(order.allProduct!) as List)
                                .map((data) => OrderProduct.fromJson(data))
                                .toList();
                            return Column(
                              children: [
                                Container(
                                  height: 54,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                      width: 1,
                                      color: bodyBlack
                                    ),  top: BorderSide(
                                      width: 1,
                                      color: bodyBlack
                                    ),
                                    )
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BodyText(
                                                text: 'Order ID',
                                                fontSize: 14,
                                                align: TextAlign.center,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              BodyText(
                                                  text: '1',
                                                  fontSize: 14,
                                                  align: TextAlign.center),
                                            ],
                                          )),
                                      Container(
                                        height: 60,
                                        width: 0.5,
                                        color: bodyBlack.withOpacity(0.4),
                                      ),
                                      const Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BodyText(
                                                text: 'Product',
                                                fontSize: 14,
                                                align: TextAlign.center,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              BodyText(
                                                text: '10',
                                                fontSize: 14,
                                                align: TextAlign.center,
                                              ),
                                            ],
                                          )),

                                      Container(
                                        height: 46,
                                        width: 0.5,
                                        color: bodyBlack.withOpacity(0.4),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const BodyText(
                                                text: 'Order Amount',
                                                fontSize: 14,
                                                align: TextAlign.center,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              BodyText(
                                                text: order.totalAmount.toString(),
                                                fontSize: 14,
                                                align: TextAlign.center,
                                              ),
                                            ],
                                          )),
                                      Container(
                                        height: 60,
                                        width: 0.5,
                                        color: bodyBlack.withOpacity(0.4),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const BodyText(
                                                text: 'Order Date',
                                                fontSize: 14,
                                                align: TextAlign.center,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              BodyText(
                                                  text: getDDMMYYYYDateStringDate(order.createdAt.toString()),
                                                  fontSize: 14,
                                                  align: TextAlign.center),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          width: 1,
                                          color: bodyLightBlack
                                      ))
                                  ),
                                  child: Row(
                                    children: [
                                    const Expanded(
                                        flex: 2,
                                        child: BodyText(
                                          text: 'Date',
                                          fontSize: 14,
                                          align: TextAlign.center,
                                          color: primaryColor,
                                        )),
                                    Container(
                                      height: 46,
                                      width: 0.5,
                                      color: bodyBlack.withOpacity(0.4),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: BodyText(
                                        text: 'Amount',
                                        fontSize: 14,
                                        align: TextAlign.center,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      height: 46,
                                      width: 0.5,
                                      color: bodyBlack.withOpacity(0.4),
                                    ),
                                    const Expanded(
                                        flex: 2,
                                        child: BodyText(
                                          text: 'Type',
                                          fontSize: 14,
                                          align: TextAlign.center,
                                          color: primaryColor,
                                        )),
                                    Container(
                                      height: 46,
                                      width: 0.5,
                                      color: bodyBlack.withOpacity(0.4),
                                    ),
                                    const Expanded(
                                        flex: 2,
                                        child: BodyText(
                                          text: 'Due Amount',
                                          fontSize: 14,
                                          align: TextAlign.center,
                                          color: primaryColor,
                                        )),
                                  ],),
                                ),
                                ListView.builder(
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                            border: Border(bottom: BorderSide(
                                                width: 0.5,
                                                color: bodyLightBlack
                                            ))
                                        ),
                                        child: Row(
                                            children: [
                                          const Expanded(
                                              flex: 2,
                                              child: BodyText(
                                                  text: '12-12-2023',
                                                  fontSize: 14,
                                                  align: TextAlign.center)),
                                          Container(
                                            height: 46,
                                            width: 0.5,
                                            color: bodyBlack.withOpacity(0.4),
                                          ),
                                          const Expanded(
                                              flex: 2,
                                              child: BodyText(
                                                  text: '5000',
                                                  fontSize: 14,
                                                  align: TextAlign.center)),
                                          Container(
                                            height: 46,
                                            width: 0.5,
                                            color: bodyBlack.withOpacity(0.4),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: BodyText(
                                                text: 'Online',
                                                fontSize: 14,
                                                align: TextAlign.center),
                                          ),
                                          Container(
                                            height: 46,
                                            width: 0.5,
                                            color: bodyBlack.withOpacity(0.4),
                                          ),
                                          const Expanded(
                                              flex: 2,
                                              child: BodyText(
                                                  text: '5000',
                                                  fontSize: 14,
                                                  align: TextAlign.center)),
                                        ]),
                                      );
                                    })
                              ],
                            );
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      decoration: const BoxDecoration(
                          color: bodyWhite,
                          border: Border(
                          top: BorderSide(
                            width: 0.5, color: bodyLightBlack
                          )
                        )
                      ),
                      child: Positioned(
                        bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                        children: [
                           Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BodyText(
                                    text: 'Order Total Amount',
                                    fontSize: 14.h,
                                    align: TextAlign.center,
                                    color: primaryColor,
                                  ),
                                  BodyText(
                                      text: '${rupeesSymbol}100000',
                                      fontSize: 14.h,
                                      align: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: bodyBlack.withOpacity(0.4),
                          ),
                           Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BodyText(
                                    text: 'Order Pending Amount',
                                    fontSize: 14.h,
                                    align: TextAlign.center,
                                    color: primaryColor,
                                  ),
                                  BodyText(
                                    text: '${rupeesSymbol}10000',
                                    fontSize: 14.h,
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              )),
                        ],
                      )),
                    ),
                  )

                ],
              );
        },
      ),
    );
  }
}

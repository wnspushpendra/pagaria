import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class LedgerScreen extends StatefulWidget {
  final String distributorId;

  const LedgerScreen({required this.distributorId, super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  bool loadOrder = true;
  List<OrderList> orderList = [];
  List<OrderProduct> productList = [];

  @override
  void initState() {
    context.read<OrderBloc>().add(OrderListFetchEvent(distributorId: widget.distributorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Ledger',
          () => Navigator.pushReplacementNamed(context, customerRoute)),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            loadOrder = false;
            if (state.orderList != null) {
              orderList = state.orderList!;
              print(orderList.length);
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
              : ListView.builder(
              shrinkWrap: true,
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                print(orderList.length);
                OrderList order = orderList[index];
                productList = (json.decode(order.allProduct!) as List).map((data) => OrderProduct.fromJson(data)).toList();

                return Column(
                  children: [
                    Container(
                      height: 40,
                      padding: const EdgeInsets.fromLTRB(12,0, 0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: BodyText(
                                text: order.id.toString(),
                                fontSize: 16,
                                align: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BodyText(
                                      text: getDDMMYYYYDateStringDate(order.createdAt.toString()),
                                      align: TextAlign.end,
                                      fontSize: 16),
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: const Icon(Icons.download_for_offline_outlined)),
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                      onPressed: () => Navigator.pushReplacementNamed(context, ledgerDetailRoute,arguments: order),
                                      icon: const Icon(Icons.visibility_outlined))
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: bodyLightBlack,
                      height: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                const BodyText(
                                  text: 'Qty',
                                  fontSize: 14,
                                  align: TextAlign.center,
                                  color: primaryColor,
                                ),
                                BodyText(
                                    text:  productList.length.toString(),
                                    fontSize: 14,
                                    align: TextAlign.center),
                              ],
                            )),
                        Container(
                          height: 46,
                          width: 0.5,
                          color: bodyBlack.withOpacity(0.4),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                const BodyText(
                                  text: 'Paid',
                                  fontSize: 14,
                                  align: TextAlign.center,
                                  color: primaryColor,
                                ),
                                BodyText(
                                  text:
                                  order.totalAmount.toString(),
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
                            flex: 2,
                            child: Column(
                              children: [
                                const BodyText(
                                  text: 'Remaining',
                                  fontSize: 14,
                                  align: TextAlign.center,
                                  color: primaryColor,
                                ),
                                BodyText(
                                    text: order.totalAmount
                                        .toString(),
                                    fontSize: 14,
                                    align: TextAlign.center),
                              ],
                            )),
                        Container(
                          height: 46,
                          width: 0.5,
                          color: bodyBlack.withOpacity(0.4),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                const BodyText(
                                  text: 'Total Amount',
                                  fontSize: 14,
                                  align: TextAlign.center,
                                  color: primaryColor,
                                ),
                                BodyText(
                                  text:
                                  order.totalAmount.toString(),
                                  fontSize: 14,
                                  align: TextAlign.center,
                                ),
                              ],
                            )),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: bodyLightBlack,
                      height: 1,
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

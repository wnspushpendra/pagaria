import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/order_payment_status.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/pdf/pdf_products.dart';
import 'package:webnsoft_solution/modal/argument_modal/DistributorPaymentArgument.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/download_pdf_util.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';






class OrderScreen extends StatefulWidget {
  final bool? showAppbar;
  final bool? fromMenu;
  final String? distributorId;


  const OrderScreen({this.showAppbar,this.fromMenu,this.distributorId, super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool loadOrder = true;
  List<Order> orderList = [];
  String userRole = '';
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderListFetchEvent(distributorId : widget.distributorId.toString(),fromMenu: widget.fromMenu));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ChangeRoutes.openHomeScreen(context, await getUser());
        return true;
    },
      child: Scaffold(
        appBar: widget.showAppbar == true
            ? appBarWidget(context, 'Order ',() => backUserHome(context))
            : null,
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if(state is OrderSuccess){
              if(state.orderList != null){
                loadOrder = !loadOrder;
                orderList = state.orderList!;
                userRole = state.userRole!;
                setState(() {});
              }
            }
            if(state is OrderError){
              loadOrder = false;
            ChangeRoutes.unAuthorizedError(context, state.error);
              errorMessage = state.error;
              setState(() {} );
            }
          },
          builder: (context, state) {
            return loadOrder ? const Center(
              child: CustomProgressBar(),
            ) : errorMessage != null? Center(
              child: BodyText(text: errorMessage!,color: primaryColor,),
            ) :
            Container(
              padding: EdgeInsets.all(12.h),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    Order order = orderList[index];
                    String remainingAmount = order.remainingAmount ?? order.totalAmount.toString();
                  var  productList = (json.decode(order.allProduct!) as List).map((data) => OrderProduct.fromJson(data)).toList();
                  return Container(
                      padding: EdgeInsets.all(12.h),
                      margin: EdgeInsets.fromLTRB(2.h, 5.h, 2.h, 5.h),
                      decoration: defaultDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BodyText(text: getDDMMYYYYDateStringDate(order.createdAt!),fontSize: 10.h,),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BodyText(
                                    text: userRole == '4' ? customerName :  widget.distributorId == null ? 'Self' : 'Executive Name',
                                    fontSize: 14.h,
                                  ),
                                   BodyText(
                                    text: order.bookedUser!.fullName!,
                                    color: primaryColor,
                                     fontSize: 14.h,
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
                                   NormalText(
                                    text: order.bookedUser!.email!,
                                    color: primaryColor,
                                     textSize: 14.h,
                                   ),
                                ],
                              ),
                            )
                          ]),
                          Row(children: [
                             Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   BodyText(
                                    text: 'Total Product',
                                    fontSize: 14.h,
                                  ),
                                  BodyText(
                                    text: productList.length.toString() ?? '',
                                    color: primaryColor,
                                    fontSize: 14.h,
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
                                    text: 'Total Price',
                                    fontSize: 14.h,
                                  ),
                                  BodyText(
                                    text: order.totalAmount ?? '',
                                    color: primaryColor,
                                    fontSize: 14.h,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   BodyText(
                                    text: 'Order Status',
                                    fontSize: 14.h,
                                  ),
                                OrderPaymentStatus(status: order.orderStatus??''),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   BodyText(
                                    text: 'Payment Status',
                                     fontSize: 14.h,
                                  ),
                                  OrderPaymentStatus(status: order.paymentStatus??''),
                                ],
                              ),
                            ),
                          ]),
                          Space(height: 4.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                         order.paymentStatus == 'completed'? Container() :    userRole == '5' ?  CustomButton(
                                  buttonText: 'Pay Now',
                                  buttonTextSize: 14,
                                  buttonWidth: 96,
                                  buttonHeight: 40,
                                  margin: 0,
                                  buttonColor: Colors.green,
                                  radius: 20,
                                  onClick: () => ChangeRoutes.openDistributorPaymentScreen(context, DistributorPaymentArgument(orderId: order.id.toString(), totalAmount: remainingAmount))) : Container(),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AssetButton(image: downloadLedger, onPressed: ()  => downLoadInvoice(order.pdfUrl!,order.pdfName!)),
                                    const Space(width: 20,),
                                    CustomButton(
                                        buttonText: 'Detail',
                                        buttonTextSize: 14,
                                        buttonWidth: 96,
                                        buttonHeight: 40,
                                        margin: 0,
                                        radius: 20,
                                        onClick: () => Navigator.pushReplacementNamed(context, orderDetailRoute,arguments: order)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }


  downLoadInvoice(String pdfUrl,String pdfName) async{
    snackBar(context, 'file download started');
    String response = await download(Dio(),pdfUrl,pdfName);
    if(response == 'failed'){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        snackBar(context, 'File download failed');
      });
    }else{
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        snackBarButton(context, 'Invoice Download', response);
      });
    }
  }
}

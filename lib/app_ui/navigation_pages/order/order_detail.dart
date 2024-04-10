import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/order_payment_status.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({required this.order, super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<OrderProduct> productList = [];

  @override
  void initState() {
    orderProductList();
    super.initState();
  }

  orderProductList() {
    productList = (json.decode(widget.order.allProduct!) as List)
        .map((data) => OrderProduct.fromJson(data))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.order.pdfUrl);
    return WillPopScope(
      onWillPop: () async {
        ChangeRoutes.openOrderScreen(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, orderRoute,
                  arguments: true);
            },
          ),
          titleSpacing: 0,
          title: const NormalText(text: 'Order Detail'),
          actions: [

         /*   {
            File pdfFile = await OrderPdf().generateProductPdf(widget.order,productList);
            saveAndOpenPdf(pdfFile);
            }*/

            AssetButton(image: downloadLedger,color: bodyWhite, onPressed: () => downLoadInvoice(context,widget.order.pdfUrl!,"${widget.order.bookedUser!.fullName!}.pdf")),
          ],
        ),
        body: /*widget.order.pdfUrl != null ?SfPdfViewer.network(widget.order.pdfUrl!) :
       */ SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40.h)),
                        child:widget.order.bookedUser!.profileImageUrl != null && widget.order.bookedUser!.profileImageUrl != "https://pagaria.wecoderelationship.com" ?
                        CachedNetworkImage(
                          imageUrl:  widget.order.bookedUser!.profileImageUrl! ,
                          width: 80.h,
                          height: 80.h,
                          fit: BoxFit.fill,
                        ) : Image.asset(profileDefaultImage, width: 80.h,height: 80.h,)),
                    const Space(
                      width: 10,
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child:  BodyText(
                                  text: 'Order Info',
                                  align: TextAlign.start,
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyText(
                                  text: widget.order.bookedUser!.fullName!,
                                  align: TextAlign.start,
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.bold,
                                ),
                                BodyText(
                                  text: 'Order ID : ${widget.order.id}',
                                  align: TextAlign.start,
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                 BodyText(
                                  text: "$mobileNumber : ",
                                  align: TextAlign.start,
                                  fontSize: 14.h,
                                ),
                                    BodyText(
                                  text: widget.order.userData!.contactNo!,
                                  align: TextAlign.start,
                                  fontSize: 14.h,
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                     BodyText(
                                  text: "$email : ",
                                  align: TextAlign.start,
                                  fontSize: 14.h,
                                ),
                                Flexible(
                                  child: BodyText(
                                    text: widget.order.bookedUser!.email!,
                                    align: TextAlign.start,
                                    fontSize: 14.h,
                                    color: bodyBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyText(
                                  text: 'Order Date : ${getDDMMYYYYDateStringDate(widget.order.createdAt!)}',
                                  align: TextAlign.start,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    widget.order.orderStatus != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                     BodyText(
                                      text: 'Order Status :  ',
                                      fontSize: 15.h,
                                    ),
                                    OrderPaymentStatus(
                                        status: widget.order.orderStatus!),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BodyText(
                                      text: 'Order Amount: $rupeesSymbol ',
                                      fontSize: 14.h,
                                      align: TextAlign.center,
                                    ),
                                    BodyText(
                                      text: widget.order.totalAmount!,
                                      fontSize: 14.h,
                                      align: TextAlign.center,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Space(
                      height: 4.h,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.h),
                padding: EdgeInsets.symmetric(
                    horizontal: 6.h, vertical: 4.h),
                decoration: BoxDecoration(
                    border:
                    Border.all(width: 1, color: bodyLightBlack)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                /*    widget.order.bookedUser!.address != null?
                    BodyText(
                      text:
                      'Address : ${widget.order.bookedUser!.address},${widget.order.bookedUser!.city} ${widget.order.bookedUser!.state} ${widget.order.bookedUser!.zipCode}',
                      align: TextAlign.start,
                      fontSize: 14.h,
                    ) : const SizedBox.shrink(),*/
                    BodyText(
                      text: 'Order Address Details : ',
                      fontSize: 14.h,
                      fontWeight: FontWeight.bold,
                    ),
                    BodyText(
                      text:
                      '${widget.order.address ?? ''},${widget.order.city ?? ''} ${widget.order.state ?? ''} ${widget.order.landmark ?? ''} ${widget.order.zipCode ?? ''} ' ?? '',
                      align: TextAlign.start,
                      fontSize: 14.h,
                    ),
                  ],
                ),
              ),


              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: bodyLightBlack,
                    ),
                    SizedBox(
                      height: 36,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(
                              flex: 3,
                              child: BodyText(
                                text: 'Product',
                                fontSize: 14,
                                align: TextAlign.center,
                                color: primaryColor,
                              )),
                          Container(
                            height: 36,
                            width: 0.5,
                            color: bodyBlack.withOpacity(0.4),
                          ),
                          const Expanded(
                              flex: 2,
                              child: BodyText(
                                text: 'QTY',
                                fontSize: 14,
                                align: TextAlign.center,
                                color: primaryColor,
                              )),
                          Container(
                            height: 36,
                            width: 0.5,
                            color: bodyBlack.withOpacity(0.4),
                          ),
                          const Expanded(
                              flex: 2,
                              child: BodyText(
                                text: 'Unit Price',
                                fontSize: 14,
                                align: TextAlign.center,
                                color: primaryColor,
                              )),
                          Container(
                            height: 36,
                            width: 0.5,
                            color: bodyBlack.withOpacity(0.4),
                          ),
                          const Expanded(
                              flex: 2,
                              child: BodyText(
                                text: 'Total Price',
                                fontSize: 14,
                                align: TextAlign.center,
                                color: primaryColor,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: bodyLightBlack,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          var product = productList[index];
                          String unitPrice = '${product.amount! / product.quantity!}';
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                  /*    CachedNetworkImage(
                                        imageUrl: product.prodImageUrl!,
                                        width: 30,
                                        height: 30,
                                      ),
                                      const Space(
                                        width: 2,
                                      ),*/
                                      Flexible(
                                          child: BodyText(
                                        text: product.prodName!,
                                        align: TextAlign.start,
                                        fontSize: 14,
                                      )),
                                    ],
                                  )),
                              Container(
                                height: 30,
                                width: 0.5,
                                color: bodyBlack.withOpacity(0.4),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: BodyText(
                                    text: product.quantity.toString() ?? '',
                                    align: TextAlign.center,
                                    fontSize: 14,
                                  )),
                              Container(
                                height: 30,
                                width: 1,
                                color: bodyBlack.withOpacity(0.4),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: BodyText(
                                    text: unitPrice,
                                    align: TextAlign.center,
                                    fontSize: 14,
                                  )),
                              Container(
                                height: 30,
                                width: 1,
                                color: bodyBlack.withOpacity(0.4),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: BodyText(
                                    text: product.amount!.toString(),
                                    align: TextAlign.center,
                                    fontSize: 14,
                                  )),
                            ],
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: bodyLightBlack,
                    ),
                    widget.order.paymentStatus != null &&
                            widget.order.paymentDetails!.isNotEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            alignment: AlignmentDirectional.topStart,
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.5, color: bodyLightBlack))),
                            child: BodyText(
                              text: 'Payment Details',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.h,
                            ),
                          )
                        : Container(),
                    widget.order.paymentStatus != null &&
                            widget.order.paymentDetails!.isNotEmpty
                        ? Container(
                       height: 36,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5, color: bodyLightBlack))),
                      child: Row(children: [
                             Expanded(
                                flex: 2,
                                child: BodyText(
                                    text: 'Date',
                                    fontSize: 14.h,
                                    align: TextAlign.center,fontWeight: FontWeight.bold,)),
                            Container(
                              height: 46,
                              width: 0.5,
                              color: bodyBlack.withOpacity(0.4),
                            ),
                             Expanded(
                                flex: 2,
                                child: BodyText(
                                    text: 'Paid Amount',
                                    fontSize: 13.h,
                                    align: TextAlign.center,fontWeight: FontWeight.bold)),
                            Container(
                              height: 46,
                              width: 0.5,
                              color: bodyBlack.withOpacity(0.4),
                            ),
                             Expanded(
                              flex: 2,
                              child: BodyText(
                                text: 'Payment Type',
                                fontSize: 13.h,
                                align: TextAlign.center,color: bodyBlack,fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 46,
                              width: 0.5,
                              color: bodyBlack.withOpacity(0.4),
                            ),
                             Expanded(
                                flex: 2,
                                child: BodyText(
                                    text: 'Due Amount',
                                    fontSize: 13.h,
                                    align: TextAlign.center,fontWeight: FontWeight.bold)),
                          ]),
                        )
                        : Container(),
                    widget.order.paymentDetails!.isNotEmpty
                        ? ListView.builder(
                            itemCount: widget.order.paymentDetails!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              PaymentDetails paymentDetail =
                                  widget.order.paymentDetails![index];
                              return Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 0.5,
                                            color: bodyLightBlack))),
                                child: Row(
                                    children: [
                                  Expanded(
                                      flex: 2,
                                      child: BodyText(
                                          text: paymentDetail.date != null ? getDDMMYYYYDateStringDate(paymentDetail.date!) :getDDMMYYYYDateStringDate(widget.order.createdAt!),
                                          fontSize: 14.h,
                                          align: TextAlign.center)),
                                  Container(
                                    height: 46,
                                    width: 0.5,
                                    color: bodyBlack.withOpacity(0.4),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: BodyText(
                                          text:  '$rupeesSymbol${paymentDetail.amount == null ?  '0' : paymentDetail.amount.toString()}',
                                          fontSize: 14.h,
                                          color: Colors.green,
                                          align: TextAlign.center)),
                                  Container(
                                    height: 46,
                                    width: 0.5,
                                    color: bodyBlack.withOpacity(0.4),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: NormalText(
                                        text: paymentDetail.paymentType ?? '-',
                                        textSize: 14.h,
                                        align: TextAlign.center,color: bodyBlack,),
                                  ),
                                  Container(
                                    height: 46,
                                    width: 0.5,
                                    color: bodyBlack.withOpacity(0.4),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: BodyText(
                                          text: paymentDetail.dueAmount.toString() ?? '',
                                          fontSize: 14.h,
                                          align: TextAlign.center)),
                                ]),
                              );
                            })
                        : Container(),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 4.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BodyText(
                                      text: 'Paid Amount: $rupeesSymbol',
                                      fontSize: 14.h,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Flexible(
                                        child: BodyText(
                                      text: widget.order.paymentAmount ?? '0',
                                      align: TextAlign.start,
                                      fontSize: 14.h,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: widget.order.paymentAmount == widget.order.totalAmount ?
                                BodyText(
                                  text: 'Paid',
                                  fontSize: 14.h,
                                  align: TextAlign.end,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                )
                               : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                     BodyText(
                                      text: 'Total Due : $rupeesSymbol',
                                      fontSize: 14.h,
                                      align: TextAlign.center,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    BodyText(
                                      text: widget.order.remainingAmount ?? widget.order.totalAmount??'',
                                      fontSize: 14,
                                      align: TextAlign.center,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    const Space(
                      height: 8,
                    ),
                    widget.order.remark != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BodyText(
                                text: 'Remark : ',
                                fontWeight: FontWeight.bold,
                              ),
                              Flexible(
                                  child: BodyText(
                                text: widget.order.remark!,
                                align: TextAlign.start,
                              ))
                            ],
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
/*SfPdfViewer.network(
        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
        canShowScrollHead: false,
        canShowPaginationDialog: false,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          // Handle load failed event
          print("error :  ${details.error}");
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          print('Document loaded');
        },
      )*/
}

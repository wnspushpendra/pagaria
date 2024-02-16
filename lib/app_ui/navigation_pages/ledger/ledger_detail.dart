import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class LedgerDetailScreen extends StatefulWidget {
  final OrderList order;
  const LedgerDetailScreen({required this.order,super.key});

  @override
  State<LedgerDetailScreen> createState() => _LedgerDetailScreenState();
}

class _LedgerDetailScreenState extends State<LedgerDetailScreen> {
  List<OrderProduct> productList = [];

  @override
  void initState() {
    orderProductList();
    super.initState();
  }

  orderProductList(){
    productList = (json.decode(widget.order.allProduct!) as List).map((data) => OrderProduct.fromJson(data)).toList();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
                Navigator.pushReplacementNamed(context, homeRoute,arguments: await getUser());
              });
            },
          ),
          titleSpacing: 0,
          title: const NormalText(text:'Order Detail' ),
          actions: [
            IconButton(onPressed: (){
         // downloadAndOpenFile();
            }, icon: const Icon(Icons.download_for_offline,color: bodyWhite,))
        ],
      ),


      body:
      SingleChildScrollView(
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
                  SizedBox(
                      width : 80,
                      height: 100,
                      child: CachedNetworkImage(imageUrl: widget.order.userData!.profileImageUrl!,width: 80,height: 80,)),
                  const Space(width: 10,),
                   Expanded(
                      flex : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width : MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: const BodyText(text: 'Order Info',align: TextAlign.start,fontSize : 18,fontWeight: FontWeight.bold,)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText(text: widget.order.userData!.fullName!,align: TextAlign.start,fontSize : 14,fontWeight: FontWeight.bold,),
                               BodyText(text: 'Order ID : ${widget.order.id}',align: TextAlign.start,fontSize : 14,fontWeight: FontWeight.bold,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               BodyText(text: widget.order.userData!.contactNo!,align: TextAlign.start,fontSize : 14,),
                              BodyText(text: widget.order.userData!.email!,align: TextAlign.start,fontSize : 14,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               BodyText(text: 'Order On : ${getDDMMYYYYDateStringDate(widget.order.createdAt!)}',align: TextAlign.start,fontSize : 14,),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BodyText(text:'Address : ${widget.order.userData!.address},${widget.order.userData!.city} ${widget.order.userData!.state} ${widget.order.userData!.zipCode}' ,align: TextAlign.start,fontSize : 14,),
            ),


            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
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
                      children:<Widget> [
                        const Expanded(flex: 3, child: BodyText(text: 'Product',
                          fontSize: 14
                          ,align: TextAlign.start,color: primaryColor,)),
                        Container(
                          height: 36,
                          width: 0.5,
                          color: bodyBlack.withOpacity(0.4),
                        ),
                        const Expanded(flex: 2, child: BodyText(text: 'Qty',
                          fontSize: 14
                          ,align: TextAlign.center,color: primaryColor,)),
                        Container(
                          height: 36,
                          width: 0.5,
                          color: bodyBlack.withOpacity(0.4),
                        ),
                        const Expanded(flex: 2, child: BodyText(text: 'Unit Price',
                          fontSize: 14,
                          align: TextAlign.center,color: primaryColor,)),
                        Container(
                          height: 36,
                          width: 0.5,
                          color: bodyBlack.withOpacity(0.4),
                        ),
                        const Expanded(flex: 2, child: BodyText(text: 'Total Price',
                          fontSize: 14,
                          align: TextAlign.center,color: primaryColor,)),

                      ],
                                       ),
                   ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: bodyLightBlack,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context,index){
                        var product = productList[index];
                        String unitPrice = '${product.amount! / int.parse(product.quantity!)}';
                        return  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget> [
                             Expanded(flex: 3, child: Row(
                               children: [
                                 CachedNetworkImage(imageUrl: product.prodImageUrl!,width: 30,height: 30,),
                                 const Space(width: 2,),
                                 Flexible(child: BodyText(text: product.prodName!,align: TextAlign.start,fontSize: 14,)),
                               ],
                             )),
                            Container(
                              height: 30,
                              width: 0.5,
                              color: bodyBlack.withOpacity(0.4),
                            ),
                             Expanded(flex: 2, child: BodyText(text: product.quantity!,align: TextAlign.center,fontSize: 14,)),
                            Container(
                              height: 30,
                              width: 1,
                              color: bodyBlack.withOpacity(0.4),
                            ),
                             Expanded(flex: 2, child: BodyText(text:  unitPrice,align: TextAlign.center,fontSize: 14,)),
                            Container(
                              height: 30,
                              width: 1,
                              color: bodyBlack.withOpacity(0.4),
                            ),
                             Expanded(flex: 2, child: BodyText(text: product.amount!.toString(),align: TextAlign.center,fontSize: 14,)),
                          ],
                        );
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: bodyLightBlack,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:<Widget> [
                    /*  Expanded(flex: 2, child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BodyText(text: 'Total Item ', fontSize: 14,align: TextAlign.end,color: primaryColor,),
                          BodyText(text: ' 10', fontSize: 14,align: TextAlign.start,),
                        ],
                      )),*/
                    /*  Expanded(flex: 2, child: Column(
                        children: [
                          BodyText(text: 'Total Qty', fontSize: 14,align: TextAlign.center,color: primaryColor,),
                          BodyText(text: ' 100', fontSize: 14,align: TextAlign.start,),
                        ],
                      )),*/
                    /*  SizedBox(
                        width: 200
                      , child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText(text: 'Order Subtotal', fontSize: 14, align: TextAlign.center,),
                              BodyText(text: widget.order.totalAmount!, fontSize: 14, align: TextAlign.center,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText(text: 'Tax', fontSize: 14, align: TextAlign.center,),
                              BodyText(text: '5000', fontSize: 14, align: TextAlign.center,),
                            ],
                          ),
                        ],
                      )),*/

                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                    /*    Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          width: 210,
                          height: 1,
                          color: primaryColor,
                        ),*/
                         SizedBox(
                          width: 200,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BodyText(text: 'Total ', fontSize: 14, align: TextAlign.center,fontWeight: FontWeight.bold,),
                              BodyText(text: widget.order.totalAmount!, fontSize: 14, align: TextAlign.center,fontWeight: FontWeight.bold,),
                            ],
                          ),
                        ),
                        Container(
                          width: 210,
                          height: 1,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            )
          ],
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
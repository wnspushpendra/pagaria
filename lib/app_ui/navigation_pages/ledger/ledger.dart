import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/asset_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/pdf/pdf_products.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/ledger/ledger_modal.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class LedgerScreen extends StatefulWidget {
  final LedgerArgument argument;

  const LedgerScreen({required this.argument, super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  bool loadOrder = true;
  List<Ledger> ledgerList = [];
  List<PaymentDetails> paymentDetailList = [];
  String ledgerTotal = '';
  String ledgerDue = '';
  String? url;
  String? errorMessage;
  late PdfViewerController _pdfViewerController;


  @override
  void initState() {

    // context.read<LedgerBloc>().add(LedgerFetchEvent(distributorId: widget.argument.distributorId!));
    context.read<LedgerBloc>().add(LedgerDownloadEvent(distributorId: widget.argument.distributorId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => widget.argument.fromDistributor == true ? ChangeRoutes.openHomeScreen(context, await getUser())
          :    ChangeRoutes.openCustomerScreen(context, widget.argument.distributorId),
      child: Scaffold(
        appBar: widget.argument.showAppbar == false ? null :  AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: bodyWhite,
                  ),
                  onPressed: () async => widget.argument.fromDistributor == true ? ChangeRoutes.openHomeScreen(context, await getUser())
                   :    ChangeRoutes.openCustomerScreen(context, widget.argument.distributorId),
                ),
                backgroundColor: primaryColor,
                title: const NormalText(text: 'Ledger'),
                actions: [
                  if(url != null)
                  IconButton(onPressed: () => downLoadInvoice(context,url!,"my-ledger-${widget.argument.distributorId}.pdf"),
                      icon: Image.asset(downloadLedger,width: 28,color: bodyWhite,))
                ],
              ),
        body: BlocConsumer<LedgerBloc, LedgerState>(
          listener: (context, state) {
            if (state is LedgerSuccess) {
              loadOrder = false;
              ledgerList = state.ledgerList;
              ledgerTotal = state.ledgerTotal;
              ledgerDue = state.ledgerPendingTotal;
              setState(() {});
            }
            if (state is LedgerDownloadSuccess) {
              url = state.url;
              setState(() {});
            }
            if (state is LedgerError) {
              loadOrder = false;
              errorMessage = state.error;
              setState(() {});
            }
          },
          builder: (context, state) {
            return errorMessage != null ? Center(
              child: BodyText(text: errorMessage!,color: primaryColor,),
            ):
              url == null
                ? const Center(
                    child: CustomProgressBar(),
                  )
                : SfPdfViewer.network(
                    url!,
                    canShowScrollHead: false,
                    pageSpacing: 0,
                  );

             Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ledgerList.length,
                          itemBuilder: (context, index) {
                            Ledger ledgerOrder = ledgerList[index];
                            if(ledgerOrder.paymentDetails != null && ledgerOrder.paymentDetails!.isNotEmpty){
                              paymentDetailList = ledgerOrder.paymentDetails!;
                            }
                            var  productList = (json.decode(ledgerOrder.allProduct!) as List).map((data) => OrderProduct.fromJson(data)).toList();

                            return Column(
                              children: [
                                Container(
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
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 54,
                                        child: Row(
                                          children: [
                                             Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const BodyText(
                                                      text: 'Order ID',
                                                      fontSize: 14,
                                                      align: TextAlign.center,
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    BodyText(
                                                        text: ledgerOrder.id.toString()??'',
                                                        fontSize: 14,
                                                        align: TextAlign.center),
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
                                                      text: 'Product',
                                                      fontSize: 14,
                                                      align: TextAlign.center,
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    BodyText(
                                                      text: productList.length.toString() ?? '',
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
                                                      text: ledgerOrder.totalAmount.toString(),
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
                                                        text: getDDMMYYYYDateStringDate(ledgerOrder.createdAt.toString()),
                                                        fontSize: 14,
                                                        align: TextAlign.center),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        width: MediaQuery.of(context).size.width,
                                        color: bodyBlack.withOpacity(0.4),
                                      ),
                                      Padding(
                                        padding : const EdgeInsets.symmetric(horizontal : 8,vertical: 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex : 1,
                                              child: Row(
                                                children: [
                                                  const BodyText(text: 'Order Amount : ',fontSize: 16,),
                                                  BodyText(text: ledgerOrder.totalAmount??'',fontSize: 16,fontWeight: FontWeight.bold,),

                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex : 1,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  const BodyText(text: 'Paid Amount : ',fontSize: 16,),
                                                  BodyText(text: ledgerOrder.paymentAmount??'',fontSize: 16,fontWeight: FontWeight.bold,),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                paymentDetailList.isNotEmpty ? Container(
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
                                ) : Container(),
                                paymentDetailList.isNotEmpty ? ListView.builder(
                                    itemCount: paymentDetailList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      PaymentDetails paymentDetail = paymentDetailList[index];
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
                                           Expanded(
                                              flex: 2,
                                              child: BodyText(
                                                  text: paymentDetail.date??'',
                                                  fontSize: 14,
                                                  align: TextAlign.center)),
                                          Container(
                                            height: 46,
                                            width: 0.5,
                                            color: bodyBlack.withOpacity(0.4),
                                          ),
                                           Expanded(
                                              flex: 2,
                                              child: BodyText(
                                                  text: paymentDetail.amount.toString()??'',
                                                  fontSize: 14,
                                                  align: TextAlign.center)),
                                          Container(
                                            height: 46,
                                            width: 0.5,
                                            color: bodyBlack.withOpacity(0.4),
                                          ),
                                           Expanded(
                                            flex: 2,
                                            child: BodyText(
                                                text: paymentDetail.paymentType??'',
                                                fontSize: 14,
                                                align: TextAlign.center),
                                          ),
                                          Container(
                                            height: 46,
                                            width: 0.5,
                                            color: bodyBlack.withOpacity(0.4),
                                          ),
                                           Expanded(
                                              flex: 2,
                                              child: BodyText(
                                                  text: paymentDetail.dueAmount.toString()??'',
                                                  fontSize: 14,
                                                  align: TextAlign.center)),
                                        ]),
                                      );
                                    }) : Container()
                              ],
                            );
                          }),
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
                                        text: rupeesSymbol+ledgerTotal,
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
                                      text: rupeesSymbol+ ledgerDue,
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
      ),
    );
  }

  appBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: bodyWhite,
        ),
        onPressed: () => ChangeRoutes.openCustomerScreen(
            context, widget.argument.distributorId),
      ),
      backgroundColor: primaryColor,
      title: const NormalText(text: 'Ledger'),
      actions: [
        AssetButton(image: downloadLedger, onPressed: () {}),
      ],
    );
  }

  downloadLedgerFile(File file, String myId) {
    ProductsPdf.saveAndOpenPdf(file,context);
  }
}

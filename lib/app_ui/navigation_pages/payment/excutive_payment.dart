import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/error_widget.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ExecutivePaymentScreen extends StatefulWidget {
  const ExecutivePaymentScreen({super.key,});

  @override
  State<ExecutivePaymentScreen> createState() => _ExecutivePaymentScreenState();
}

class _ExecutivePaymentScreenState extends State<ExecutivePaymentScreen> {
  List<String> paymentOption = [qrCodePayment, upiPayment, bankPayment, cardPayment, cashPayment];
  TextEditingController amountToPayController = TextEditingController();
  TextEditingController referenceIdController = TextEditingController();
  String? customerName,paymentType,paymentTransferType;
  File? file;
  String path = '';
  bool firmCustomerLoading = true,remainingAmountError= false;
  List<Firm> firmList = [];
  Firm? firmValue;
  List<AllCustomer>? customerList;
  AllCustomer? customerValue;
  String dueAmount = '';
  int totalAmount = 0;
  int remainingAmount = 0;
  String customerId = '';
  bool? customerSelectError,paymentError, paymentTypeError,paymentLoading,fetchPaymentLoading;



  @override
  void initState() {
    // call api for getting firm and their customer
    context.read<PaymentBloc>().add(FetchFirmCustomerEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        ChangeRoutes.openHomeScreen(context, await getUser());
        return true;
      },
      child: Scaffold(
        appBar: appBarWidget(context, payment, () async {
          ChangeRoutes.openHomeScreen(context, await getUser());
        }),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if(state is PaymentSuccess){
              firmCustomerLoading = false;
              if(state.firmList != null){
                firmList  = state.firmList ?? [];
              }
              if(state.dueAmount != null){
                fetchPaymentLoading = false;
                dueAmount  = state.dueAmount ?? '';
                totalAmount  = int.parse(state.totalAmount!) ?? 0;
                setState(() {});
              }
              if(state.paymentRecord != null){
                ChangeRoutes.openOrderScreen(context, true);
              }

              if(state.order!= null){
               // ChangeRoutes.openOrderDetailScreen(context, state.order![0]);
              }

              if(state.paymentSuccessAmount != null){
                paymentLoading = false;
                int paidAmount = state.paymentSuccessAmount!;
                int changeDueAmount = int.parse(dueAmount) - paidAmount;
                dueAmount = changeDueAmount.toString();
                amountToPayController.text = '';
              }


              setState(() {});
            }
            if(state is PaymentError){
              ChangeRoutes.unAuthorizedError(context, state.error);
              firmCustomerLoading = false;
              paymentLoading = false;
              fetchPaymentLoading = false;
              paymentErrorState(state);
              snackBar(context, state.error!);
              setState(() {});
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                child:firmCustomerLoading ?
                    const Center(
                      child: CustomProgressBar(),
                    )
                : Column(
                  children: <Widget>[
                    CustomDropDown(
                        type: 'firm',
                        hint: firmList.isEmpty ? 'No Firm' : 'Select Firm ',
                        firmList: firmList,
                        selectedFirmValue: firmValue,
                        onChangeFirm: (value) => setState(() {
                          firmValue = value;
                          customerList = value.allCustomer ?? [];
                        }), ),
                    customerList != null ?  CustomDropDown(
                        type: 'customer',
                        hint: 'Select Customer ',
                        customerList: customerList,
                        selectedCustomerValue: customerValue,
                        onChangeCustomer: (value) => setState((){
                          fetchPaymentLoading = true;
                          dueAmount = '';
                          customerId = value.id.toString();
                          customerValue = value;
                          customerName = value.fullName;
                          context.read<PaymentBloc>().add(FetchCustomerDueAmountEvent(customerId: customerId));
                        })) : Container(),

                    fetchPaymentLoading == true ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomProgressBar(widthV: 20,heightV: 20,),
                    ) : Container(),
                    dueAmount.isNotEmpty?   Row(
                      children: [
                        BodyText(
                          text: duePayment,
                          fontSize: 14.h,
                        ),
                         BodyText(
                          text: dueAmount,
                          color: primaryColor,
                        ),
                      ],
                    ) : Container(),
                  dueAmount.isNotEmpty ?  CustomTextField(
                        hint: enterPayment,
                        label: enterPayment,
                        inputFormatter: InputFieldFormatter.numberFormat,
                        maxLength: 10,
                        validate: remainingAmountError,
                        errorMessage: remainingAmountGreaterMessage,
                        controller: amountToPayController,
                        onTextChange: (value) {
                          remainingAmount = int.parse(dueAmount)  - int.parse(amountToPayController.text);
                         remainingAmountError = false;
                          if(remainingAmount.isNegative){
                            remainingAmountError = true;
                          }
                          setState(() {});
                        }) : Container(),

                    remainingAmount != 0 ? Row(
                      children: [
                        BodyText(
                          text: remainingPayment,
                          fontSize: 12.h,
                        ),
                        BodyText(
                          text: remainingAmount.isNegative ? 'Enter amount is not valid.' : remainingAmount.toString(),
                          color:remainingAmount.isNegative ? Colors.red : Colors.orangeAccent,
                          fontSize: 14.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ) : Container(),
                    amountToPayController.text.isNotEmpty ?   CustomDropDown(
                        hint: selectPaymentOption,
                        itemList: paymentOption,
                        selectedValue: paymentType,
                        onChangeValue: (value) {
                          paymentType = value;
                          if(value == cashPayment){
                            paymentTransferType = 'cash';
                          }else if(value == upiPayment){
                            paymentTransferType = 'upi_payment';
                          }else if(value == qrCodePayment){
                            paymentTransferType = 'qr_code_scan';
                          }else if(value == cardPayment){
                            paymentTransferType = 'card_payment';
                          }else if(value == bankPayment){
                            paymentTransferType = 'bank_transfer';
                          }
                          setState(() {});
                          },
                      type: '',) : Container(),
                   // paymentTypeError == false ? const SizedBox.shrink() : CustomErrorWidget(validate: !paymentTypeError! , errorMessage: genderMessage),
                    paymentType != null ? CustomTextField(
                        hint: referenceNumberMessage,
                        label: referenceNumberMessage,
                        controller: referenceIdController,
                        onTextChange: (value) {}) : Container(),
                    const Space(height: 8,),
                    paymentType != null ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomButton(
                          buttonHeight: 40,
                            buttonWidth: 130,
                            margin: 0,
                            buttonTextSize: 14,
                            buttonColor: bodyLightBlack,
                            buttonText: attachment, onClick: (){
                          pickSingleFile().then((value) {
                            if(value != null){
                              path = value.path;
                              file = File(value.path);
                              setState(() {});
                            }
                          });
                          }),
                        const Space(width: 10,),
                        file == null ? Container()
                            : Expanded(
                          flex: 1, child: Image.file(file!))
                      ],
                    ) : Container(),
                    paymentType != null ? CustomButton(buttonText: submit,
                        showLoading: paymentLoading,
                        onClick: () => makePayment(customerId)) : Container()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  makePayment(String customerId) {
    if(!remainingAmount.isNegative){
      paymentLoading = true;
      setState(() {});
      context.read<PaymentBloc>().add(PaymentClickEvent(customerId: customerId, payableAmount: amountToPayController.text, paymentOption: paymentTransferType, paymentReferenceNumber: referenceIdController.text, path: path));
    }else{
      snackBar(context, remainingAmountGreaterMessage);
    }
  }

  void paymentErrorState(PaymentError state) {
    paymentError = state.payableAmount;
    paymentTypeError = state.paymentOption;
  }
}

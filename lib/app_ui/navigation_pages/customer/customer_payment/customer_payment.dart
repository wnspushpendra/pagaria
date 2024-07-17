import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerPaymentScreen extends StatefulWidget {
  //final Customer customer;
  final User customer;
  const CustomerPaymentScreen( {required this.customer,super.key});

  @override
  State<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}
class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  List<String> paymentOption = [qrCodePayment, upiPayment, bankPayment, cardPayment, cashPayment];
  TextEditingController amountToPayController = TextEditingController();
  TextEditingController referenceIdController = TextEditingController();
  String? customerName,paymentType,paymentTransferType;
  File? file;
  String path = '';
  bool customerPaymentDetailLoading = true,remainingAmountError= false;
  String dueAmount = '';
  int totalAmount = 0;
  int remainingAmount = 0;
  String customerId = '';
  bool? customerSelectError,paymentError, paymentTypeError,paymentLoading;
  String? errorMessage;


  @override
  void initState() {
    // api call for customer payment detail fetch
    context.read<PaymentBloc>().add(FetchCustomerDueAmountEvent(customerId: widget.customer.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if(state is PaymentSuccess){
            customerPaymentDetailLoading = false;
            if(state.dueAmount != null){
              dueAmount  = state.dueAmount ?? '';
              totalAmount  = int.parse(state.totalAmount!);
            }
            if(state.paymentRecord!= null){
              ChangeRoutes.openOrderScreen(context, true);
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

            customerPaymentDetailLoading = false;
            paymentLoading = false;
            errorMessage = state.error!;
         //   snackBar(context, state.error!);
            setState(() {});
          }
        },
        builder: (context, state) {
          return dueAmount == '0' ? Container(
            height: MediaQuery.of(context).size.height,
            alignment: AlignmentDirectional.center,
            child: const BodyText(text: 'No due payment.',color: primaryColor,),
          ):
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              child:  customerPaymentDetailLoading ?
                  const Center(
                    child: CustomProgressBar(),
                  )

             : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  const Space(height: 10,),
                  CustomTextField(
                      hint: enterPayment,
                      label: enterPayment,
                      inputFormatter: InputFieldFormatter.numberFormat,
                      maxLength: 10,
                      validate: remainingAmountError,
                      errorMessage: remainingAmountGreaterMessage,
                      controller: amountToPayController,
                      onTextChange: (value) {
                        remainingAmount = int.parse(dueAmount)  - int.parse(amountToPayController.text);
                        print(remainingAmount.toString());
                        remainingAmountError = false;
                        if(remainingAmount.isNegative){
                          remainingAmountError = true;
                        }
                        setState(() {});
                      }) ,
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
                          flex: 1,
                          child: Image.file(file!))
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
    );
  }

  makePayment(String customerId) {
    if(!remainingAmount.isNegative){
      paymentLoading = true; setState(() {});
      context.read<PaymentBloc>().add(PaymentClickEvent(customerId: widget.customer.id.toString(), payableAmount: amountToPayController.text, paymentOption: paymentTransferType, paymentReferenceNumber: referenceIdController.text, path: path));
    }else{
      snackBar(context, remainingAmountGreaterMessage);
    }
  }
}

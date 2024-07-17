import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class DistributorPaymentScreen extends StatefulWidget {
  final String customerId;
  const DistributorPaymentScreen( {required this.customerId,super.key});

  @override
  State<DistributorPaymentScreen> createState() => _DistributorPaymentScreenState();
}
class _DistributorPaymentScreenState extends State<DistributorPaymentScreen> {
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

  // handle razorpay payment action

  final Razorpay _razorpay = Razorpay();


  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(FetchCustomerDueAmountEvent(customerId: widget.customerId.toString()));
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
   payUserDue(customerId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    snackBar(context,response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  makePayment(Razorpay razorpay, String amount) async{
    User user = await getUserPref(userProfileDataPrefecences);
    var options = {
      'key': 'rzp_test_X8hH8VVR92Ya21',
      'amount': int.parse(amount)*100,
      'name': user.fullName,
      'description': 'Pagaria Customer Order Payment',
      'prefill': {
        'contact': user.contactNo,
        'email': user.email
      }
    };

    razorpay.open(options);
  }


  // end razorpay payment actions




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if(state is PaymentSuccess){
            customerPaymentDetailLoading = false;
            if(state.dueAmount != null){
              customerPaymentDetailLoading = false;
              dueAmount  = state.dueAmount ?? '';
              totalAmount  = int.parse(state.totalAmount!) ?? 0;
            }
            if(state.paymentRecord != null){
              ChangeRoutes.openOrderScreen(context, true);
            }
            if(state.paymentSuccessAmount != null){
              customerPaymentDetailLoading = false;
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
           paymentLoading = false;
            errorMessage = state.error;
            customerPaymentDetailLoading = false;
           // snackBar(context, state.error!);
            setState(() {});
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: appBarWidget(context, payment, () => Navigator.pushReplacementNamed(context, orderRoute,arguments: true)),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                child:  customerPaymentDetailLoading ?
                const Center(
                  child: CustomProgressBar(),
                ) : errorMessage != null ? Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: AlignmentDirectional.center,
                  child: BodyText(text: errorMessage!,color: primaryColor,),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    dueAmount.isNotEmpty?  Row(
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
                    dueAmount.isNotEmpty && dueAmount != '0'?  CustomTextField(
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
                        }) : Container() ,
                    remainingAmount != 0 ? Row(
                      children: [
                        BodyText(
                          text: remainingPayment,
                          fontSize: 12.h,
                          color: Colors.red,
                        ),
                        BodyText(
                          text: remainingAmount.toString(),
                          color: Colors.red,
                          fontSize: 14.h,
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
                              path  = value.path;
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
                        onClick: () => makePayment(_razorpay,amountToPayController.text)) : Container()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  payUserDue(String customerId) {
    paymentLoading = true;
    setState(() {});context.read<PaymentBloc>().add(PaymentClickEvent(customerId: widget.customerId.toString(), payableAmount: amountToPayController.text, paymentOption: paymentTransferType, paymentReferenceNumber: referenceIdController.text, path: path));
  }
}

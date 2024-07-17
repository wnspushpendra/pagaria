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
import 'package:webnsoft_solution/modal/argument_modal/DistributorPaymentArgument.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class DistributorOrderPaymentScreen extends StatefulWidget {
  final DistributorPaymentArgument argument;

  const DistributorOrderPaymentScreen({required this.argument, super.key});

  @override
  State<DistributorOrderPaymentScreen> createState() =>
      _DistributorOrderPaymentScreenState();
}

class _DistributorOrderPaymentScreenState
    extends State<DistributorOrderPaymentScreen> {
  List<String> paymentOption = [
    qrCodePayment,
    upiPayment,
    bankPayment,
    cardPayment,
    cashPayment
  ];
  TextEditingController amountToPayController = TextEditingController();
  TextEditingController referenceIdController = TextEditingController();
  String? customerName, paymentType, paymentTransferType;
  File? file;
  String path = '';
  bool customerPaymentDetailLoading = true,
      remainingAmountError = false;
  String dueAmount = '';
  int totalAmount = 0;
  int remainingAmount = 0;
  String customerId = '';
  bool? customerSelectError, paymentError, paymentTypeError, paymentLoading;
  String? errorMessage;

  // handle razorpay payment action

  final Razorpay _razorpay = Razorpay();


  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    payUserDue();
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => ChangeRoutes.openOrderScreen(context, true),
      child: Scaffold(
        appBar: appBarWidget(
            context,
            payment,
                () => ChangeRoutes.openOrderScreen(context, true)),
              //  Navigator.pushReplacementNamed(context, orderRoute, arguments: true)),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if(state is PaymentSuccess){
              if(state.paymentRecord != null){
                ChangeRoutes.openOrderScreen(context, true);
              }

             // Navigator.pushReplacementNamed(context, orderRoute, arguments: true);
            }
            if(state is PaymentError){
              errorMessage = state.error;
              ChangeRoutes.unAuthorizedError(context, state.error);
              paymentLoading = false;
              setState(() {});
            }
          },
          builder: (context, state) {
            return errorMessage != null ? Container(
              height: MediaQuery.of(context).size.height,
              alignment: AlignmentDirectional.center,
              child: BodyText(text: errorMessage!,color: primaryColor,),
            )
              : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomDropDown(
                      hint: selectPaymentOption,
                      itemList: paymentOption,
                      selectedValue: paymentType,
                      onChangeValue: (value) {
                        paymentType = value;
                        if (value == cashPayment) {
                          paymentTransferType = 'cash';
                        } else if (value == upiPayment) {
                          paymentTransferType = 'upi_payment';
                        } else if (value == qrCodePayment) {
                          paymentTransferType = 'qr_code_scan';
                        } else if (value == cardPayment) {
                          paymentTransferType = 'card_payment';
                        } else if (value == bankPayment) {
                          paymentTransferType = 'bank_transfer';
                        }
                        setState(() {});
                      },
                      type: '',
                    ),
                    paymentType != null
                        ? CustomTextField(
                        hint: referenceNumberMessage,
                        label: referenceNumberMessage,
                        controller: referenceIdController,
                        onTextChange: (value) {})
                        : Container(),
                    const Space(
                      height: 8,
                    ),
                    paymentType != null
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomButton(
                            buttonHeight: 40,
                            buttonWidth: 130,
                            margin: 0,
                            buttonTextSize: 14,
                            buttonColor: bodyLightBlack,
                            buttonText: attachment,
                            onClick: () {
                              pickSingleFile().then((value) {
                                if (value != null) {
                                  path = value.path;
                                  file = File(value.path);
                                  setState(() {});
                                }
                              });
                            }),
                        const Space(
                          width: 10,
                        ),
                        file == null
                            ? Container()
                            : Expanded(flex: 1, child: Image.file(file!))
                      ],
                    )
                        : Container(),
                    paymentType != null
                        ? CustomButton(
                        buttonText:
                        'Pay $rupeesSymbol ${widget.argument.totalAmount}',
                        showLoading: paymentLoading,
                        onClick: () => makePayment(_razorpay,widget.argument.totalAmount))
                        : Container()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  payUserDue() {
    paymentLoading = true;
    setState(() {});
    context.read<PaymentBloc>().add(DistributorOrderPaymentEvent(
        orderId: widget.argument.orderId.toString(),
        paymentAmount: widget.argument.totalAmount,
        paymentOption: paymentTransferType,
        paymentReferenceNumber: referenceIdController.text,
        path: path));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class PaymentScreen extends StatefulWidget {
 final OrderList? order;
  const PaymentScreen({super.key,this.order});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> paymentOption = ['QR Payment', 'UPI Transfer', 'Bank Transfer', 'Cash', 'Card Payment'];
  TextEditingController amountToPayController = TextEditingController(text: '5000');
  TextEditingController referenceIdController = TextEditingController();
  String? customerName,paymentType;
  File? file;
  bool firmCustomerLoading = true;
  List<Firm> firmList = [];
  Firm? firmValue;
  List<AllCustomer>? customerList;
  AllCustomer? customerValue;



  @override
  void initState() {
    // call api for getting firm and their customer
    context.read<PaymentBloc>().add(FetchFirmCustomerEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Payment', () async {
        Navigator.pushReplacementNamed(context, homeRoute, arguments: await getUser());
      }),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if(state is PaymentSuccess){
            firmCustomerLoading = false;
            firmList  = state.firmList!;

            setState(() {});
          }
          if(state is PaymentError){
            snackBar(context, state.error!);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  CustomDropDown(
                      type: 'firm',
                      hint: firmList.isEmpty ? 'No Firm' : 'Select Firm ',
                      firmList: firmList,
                      selectedValue: firmValue,
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
                        customerValue = value;
                        customerName = value.fullName;
                      })) : Container(),
                  Row(
                    children: [
                      BodyText(
                        text: 'Due Payment : ',
                        fontSize: 14.h,
                      ),
                      const BodyText(
                        text: '40000',
                        color: primaryColor,
                      ),
                    ],
                  ),
                  CustomTextField(
                      hint: 'Payment',
                      label: 'Payment',
                      inputFormatter: InputFieldFormatter.numberFormat,
                      maxLength: 6,
                      controller: amountToPayController,
                      onTextChange: (value) {}),
                  Row(
                    children: [
                      BodyText(
                        text: 'Remaining Payment : ',
                        fontSize: 12.h,
                        color: Colors.red,
                      ),
                      BodyText(
                        text: '20000',
                        color: Colors.red,
                        fontSize: 14.h,
                      ),
                    ],
                  ),

         /*         CustomDropDown(
                      hint: 'Select Payment Option ',
                      itemList: paymentOption,
                      selectedValue: paymentType,
                      onChange: (value) => setState(() => paymentType = value)),*/
                  CustomTextField(
                      hint: 'Reference ID',
                      label: 'Reference ID',
                      controller: referenceIdController,
                      onTextChange: (value) {}),
                  const Space(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        buttonHeight: 40,
                          buttonWidth: 130,
                          margin: 0,
                          buttonTextSize: 14,
                          buttonColor: bodyLightBlack,
                          buttonText: 'Attachment', onClick: (){
                        pickSingleFile().then((value) {
                          if(value != null){
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
                  ),

                  CustomButton(buttonText: submit, onClick: () => snackBar(context, 'payment successful'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

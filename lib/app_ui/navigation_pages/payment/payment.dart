import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_state.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> customerList = ['yuvi', 'rohit', 'dhoni', 'kl rahul', 'pant'];
  List<String> paymentOption = ['QR Payment', 'UPI Transfer', 'Bank Transfer', 'Cash', 'Card Payment'];
  TextEditingController amountToPayController = TextEditingController(text: '5000');
  String? firmName,customerName,paymentType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Payment', () async {
        Navigator.pushReplacementNamed(context, homeRoute, arguments: await getUser());
      }),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  CustomDropDown(
                      hint: 'Select Firm ',
                      itemList: customerList,
                      selectedValue: firmName,
                      onChange: (value) => setState(() => firmName = value)),
                  CustomDropDown(
                      hint: 'Select Customer ',
                      itemList: customerList,
                      selectedValue: customerName,
                      onChange: (value) => setState(() => customerName = value)),
                  Row(
                    children: [
                      BodyText(
                        text: 'Amount To Pay : ',
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
                        text: 'Remaining Amount : ',
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
                  CustomDropDown(
                      hint: 'Select Payment Option ',
                      itemList: paymentOption,
                      selectedValue: paymentType,
                      onChange: (value) => setState(() => paymentType = value)),
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

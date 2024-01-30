import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_state.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerPaymentScreen extends StatefulWidget {
  const CustomerPaymentScreen({super.key});

  @override
  State<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  List<String> customerList = ['yuvi','rohit','dhoni','kl rahul','pant'];
  List<String> paymentOption = ['QR Payment','Bank Transfer','Cash','Card Payment'];
  TextEditingController duePaymentController = TextEditingController(text: '50000');
  TextEditingController amountToPayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PaymentBloc, PaymentState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
           /*   CustomDropDown(hint: 'Select Firm ', itemList : customerList,onChange: (value){}),
              CustomDropDown(hint: 'Select Customer ', itemList : customerList,onChange: (value){}),
            */   Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HeadingText(text: 'Amount To Pay : ',fontSize: 14.h,),
                  const BodyText(text: '40000',color: primaryColor,),
                ],
              ),
              CustomTextField(hint: 'Payment', label: 'Payment', controller: amountToPayController, onTextChange: (value){}),
              Row(
                children: [
                  BodyText(text: 'Remaining Amount : ',fontSize: 12.h,color: Colors.red,),
                   BodyText(text: '20000',color: Colors.red,fontSize: 14.h,),
                ],
              ),
              CustomDropDown(hint: 'Select Payment Option ', itemList : paymentOption,onChange: (value){}),
              CustomButton(buttonText: submit, onClick: (){})

            ],
          ),
        ),
    );
  },
),
    );
  }
}

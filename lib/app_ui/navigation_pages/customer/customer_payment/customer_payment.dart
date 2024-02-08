import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_dropdow.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CustomerPaymentScreen extends StatefulWidget {
  final Customer customer;
  const CustomerPaymentScreen( {required this.customer,super.key});

  @override
  State<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  List<String> customerList = ['yuvi','rohit','dhoni','kl rahul','pant'];
  List<String> paymentOption = ['QR Payment','Bank Transfer','Cash','Card Payment'];
  TextEditingController duePaymentController = TextEditingController(text: '50000');
  TextEditingController amountToPayController = TextEditingController();
  TextEditingController referenceIdController = TextEditingController();
  File? file;

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
            */
              Row(
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

/*
              CustomDropDown(hint: 'Select Payment Option ', itemList : paymentOption,onChangeFirm: (value){}),
*/
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

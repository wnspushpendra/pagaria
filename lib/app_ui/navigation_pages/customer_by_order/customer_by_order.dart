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
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class SpecificCustomerOrder extends StatefulWidget {
  const SpecificCustomerOrder({super.key,});

  @override
  State<SpecificCustomerOrder> createState() => _SpecificCustomerOrderState();
}

class _SpecificCustomerOrderState extends State<SpecificCustomerOrder> {
  List<User> customerList = [];
  //List<Customer> customerList = [];
  bool customerLoading = true;
  bool? paymentLoading;
  User? customerValue;
 // Customer? customerValue;
  String customerId = '';


  @override
  void initState() {
    // call api for getting customer
    context.read<HomeBloc>().add(HomeCustomerFetchEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ChangeRoutes.openHomeScreen(context, await getUser());
        return true;
      },
      child: Scaffold(
        appBar: appBarWidget(context, customer, () async {
          ChangeRoutes.openHomeScreen(context, await getUser());
        }),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if(state is PaymentSuccess){
             paymentLoading =false;
              if(state.paymentRecord != null){
                ChangeRoutes.openOrderScreen(context, true);
              }
              setState(() {});
            }
            if(state is PaymentError){
              paymentLoading = false;
              snackBar(context, state.error!);
              setState(() {});
            }
          },
          builder: (context, state) {
            return BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeSuccess) {
                  if (state.distributorList != null) {
                    customerLoading = false;
                    customerList = state.distributorList!;
                    setState(() {});
                  }
                }
                if (state is HomeError) {
                  customerLoading = false;
                  snackBar(context, state.error);
                  setState(() {});
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: customerLoading ?
                    const Center(
                      child: CustomProgressBar(),
                    )
                        : Column(
                      children: <Widget>[
                        BodyText(
                          text: 'Select any customer and proceed to order submission*',
                          align: TextAlign.start,
                          color: primaryColor, fontSize: 12.h,),

                        CustomDropDown(
                          type: 'distributor',
                          hint: customerList.isEmpty
                              ? 'No Customer'
                              : 'Select Customer ',
                          distributorList: customerList,
                          selectedDistributorValue: customerValue,
                          onChangeDisrtirbutor: (value) =>
                              setState(() {
                                customerValue = value;
                                customerId = value.id.toString();
                              }),),

                        CustomButton(buttonText: submit,
                            showLoading: paymentLoading,
                            onClick: () => proceedToOrder())
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  proceedToOrder() async {
    if (customerId.isNotEmpty) {
      paymentLoading = true; setState(() {});
      ChangeRoutes.openProductScreen(context, await getUser(), customerValue);
    } else {
      snackBar(context, 'Select any customer');
    }
  }

}

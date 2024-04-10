import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_list/payment_widget.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class PaymentList extends StatefulWidget {
  final bool? fromHome;
  const PaymentList({this.fromHome,super.key});


  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  List<PaymentDetailData> paymentList = [];
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    context.read<PaymentBloc>().add(FetchPaymentListDataEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {

        if(state is PaymentSuccess){
          loading = false;
          if(state.paymentDetailList != null){
            paymentList = state.paymentDetailList!;
            setState(() {});
          }
        }
        if(state is PaymentError){
          if(state.error == 'unauthorization'){
            backToLogin(context);
          }
          errorMessage = state.error;
          setState(() => loading = false);
          widget.fromHome == true ? null : snackBar(context,state.error??'' );
        }
      },

      builder: (context, homeState) {
        return  errorMessage != null ? Container(
          alignment:  widget.fromHome == true ? Alignment.center : Alignment.center,
          child: BodyText(text: errorMessage.toString(),color: primaryColor,),
        ) : loading ?
        const Center(
          child: CustomProgressBar(),
        ) :
        ListView.builder(
            shrinkWrap: true,
            physics: widget.fromHome== true ? const NeverScrollableScrollPhysics() : null,
            itemCount: widget.fromHome == true && paymentList.length>5 ? 5  :  paymentList.length,
            itemBuilder: (context, index) {
              PaymentDetailData paymentDetail = paymentList[index];
              return GestureDetector(
                onTap: (){
                  ChangeRoutes.openPaymentDetailScreen(context, paymentDetail);
                },
                  child: PaymentWidget(paymentDetail : paymentDetail));
            });
      },
    );
  }
}

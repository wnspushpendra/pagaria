
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_apis.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/cart_api.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/payment/due_payment_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_modal.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<FetchFirmCustomerEvent>((event, emit) => fetchFirm(event));
    on<FetchCustomerDueAmountEvent>((event, emit) => duePayment(event));
    on<PaymentClickEvent>((event, emit) => makePayment(event));
    on<FetchPaymentListDataEvent>((event, emit) => paymentListData(event));
    on<DistributorOrderPaymentEvent>((event, emit) => makeOrderPaymentRequest(event));
  }
  fetchFirm(FetchFirmCustomerEvent event) async {
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['marketing_executive_id'] = user.id.toString();

try {
  FirmCustomerResponseModal response = await firmCustomerListData(header, body);
  if (response.status == true && response.firm != null &&
      response.firm!.isNotEmpty) {
    emit(PaymentSuccess(firmList: response.firm));
  } else {
    emit(PaymentError(error: response.message.toString()));
  }
}catch(e){
  emit(PaymentError(error: unAuthorization));
}

  }
  duePayment(FetchCustomerDueAmountEvent event) async{
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    if(user.roleId == '4'){
      body['executive_id'] = user.id.toString();
      body['user_id'] = event.customerId.toString();
    }else{
      body['user_id'] = event.customerId.toString();
    }
    body['user_type'] = 'type_marketing_ex';

    try {
      CustomerDueAmountModal response = await dueAmountData(header, body);
      if (response.status == true) {
        emit(PaymentSuccess(totalAmount: response.totalAmount.toString(),
            dueAmount: response.dueAmount.toString()));
      } else {
        emit(PaymentError(error: response.message.toString()));
      }
    }catch(e){
      emit(PaymentError(error: unAuthorization));
    }
  }
  makePayment(PaymentClickEvent event) async{

    bool validatePayment = paymentValidate(event);
    if(validatePayment){
      makePaymentRequest(event);
    }
  }
  bool paymentValidate(PaymentClickEvent event) {
    bool  payAmount = false,  paymentOption = false,
        referenceId = false,  attachment = false;
    payAmount =  event.payableAmount!.isEmpty;
    paymentOption = event.paymentOption == null;
    referenceId = event.paymentReferenceNumber!.isEmpty;
    attachment = event.path.isEmpty;
    if(!payAmount && !paymentOption){
      return true;
    }else{
      return false;
    }
  }
  void makePaymentRequest(PaymentClickEvent event) async {
    Map<String, String> header =  {
    "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['executive_id'] = user.id.toString();
    body['user_type'] = 'type_marketing_ex' ;
    body['user_id'] = event.customerId.toString();
    body['amount'] = event.payableAmount;
    body['payment_type'] = event.paymentOption;
    body['payment_reference_id'] = event.paymentReferenceNumber;

    try {
      CustomerPaymentModal response = await customerPaymentData(
          event.path.toString(), header, body);
      if (response.status == true /*&& response.order != null*/ &&
          response.record != null) {
        emit(PaymentSuccess(/*order: response.order,*/
            paymentRecord: response.record));
      } else {
        emit(PaymentError(error: response.message.toString()));
      }
    }catch(e){
      emit(PaymentError(error: e.toString()));
    }
  }

  void makeOrderPaymentRequest(DistributorOrderPaymentEvent event) async {
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['user_type'] = 'type_marketing_ex' ;
    body['user_id'] = user.id.toString();
    body['amount'] = event.paymentAmount;
    body['payment_type'] = event.paymentOption;
    body['payment_reference_id'] = event.paymentReferenceNumber;
    body['order_id'] = event.orderId;

    CustomerPaymentModal response = await distributorOrderPayment(event.path.toString(),header, body);
    emit(PaymentError(error: response.message.toString()));
    if(response.status == true){
      emit(PaymentSuccess(paymentRecord: response.record));
    }
  }



  paymentListData(FetchPaymentListDataEvent event) async{
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['executive_id'] = user.id.toString();

    try {
      PaymentListModal response = await customerPaymentListData(header, body);
      if (response.status == true && response.paymentDetail != null &&
          response.paymentDetail!.isNotEmpty) {
        emit(PaymentSuccess(paymentDetailList: response.paymentDetail));
      } else {
        emit(PaymentError(error: response.message.toString()));
      }
    }catch(e){
      emit(PaymentError(error: e.toString()));
    }
  }


}


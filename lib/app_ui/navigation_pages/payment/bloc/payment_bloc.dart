
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_apis.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/cart_api.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<FetchFirmCustomerEvent>((event, emit) => fetchFirm(event));
    on<PaymentClickEvent>((event, emit) => makePayment(event));
  }

  fetchFirm(FetchFirmCustomerEvent event) async {
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['marketing_executive_id'] = user.id.toString();


    FirmCustomerResponseModal response = await firmCustomerListData(header, body);
    if(response.status == true  && response.firm != null && response.firm!.isNotEmpty){
      emit(PaymentSuccess(firmList :  response.firm));
    }else{
      emit(PaymentError(error : response.message.toString()));
    }

  }

  makePayment(PaymentClickEvent event) async{

    bool validatePayment = paymentValidate(event);
    if(validatePayment){
      makePaymentRequest();
    }

  }
  bool paymentValidate(PaymentClickEvent event) {
    bool firmName = false,  customerName = false, payAmount = false,  paymentOption = false,
        referenceId = false,  attachment = false;

    firmName = event.firmName!.isEmpty;
    customerName = event.customerName!.isEmpty;
    payAmount =  event.payableAmount!.isEmpty;
    paymentOption = event.paymentOption!.isEmpty;
    referenceId = event.paymentReferenceNumber!.isEmpty;
    attachment = event.file != null;
    if(!firmName && !customerName && !payAmount && !paymentOption ){
      return true;
    }else{
      return false;
    }




  }


  void makePaymentRequest() {

  }

}


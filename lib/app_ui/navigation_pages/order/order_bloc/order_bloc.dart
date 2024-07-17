
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/order/order.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderListFetchEvent>((event, emit) =>  fetchOrderApi(event));
    on<OrderSubmitEvent>((event, emit) {
      bool validateAddress = validateDistributorAddress(event);
      if(validateAddress){
        createOrderApi(event);
      }
    });
  }

  void fetchOrderApi(OrderListFetchEvent event) async{
    // header
    Map<String, String> header =  {
    "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    User user = await getUserPref(userProfileDataPrefecences);

    // form body data
    Map<String, dynamic> body = <String, dynamic>{};

    if(user.roleId == '4' ) {
      if (event.fromMenu != false) {
        body['booked_by_id'] = user.id.toString();
      }
      else {
        body['booked_by_id'] = user.id.toString();
        body['user_id'] =  event.distributorId.toString();
      }
    }else{
    body['user_id'] = user.id.toString();
    }
    body['user_type'] = 'type_marketing_ex';

    try {
      // request
      UserRoleOrderModal response = await userOrderListApi(header, body);
      // handling response
      if (response.status == true && response.order != null && response.order!.isNotEmpty) {
        emit(OrderSuccess(orderList: response.order!, userRole: user.roleId));
      } else {
        emit(OrderError(error: response.message.toString()));
      }
    }catch(e){
      emit(OrderError(error: e.toString()));
    }
  }


  bool validateDistributorAddress(OrderSubmitEvent event) {
    bool houseNo = event.houseNo == null || event.houseNo!.isEmpty ;
    bool town = event.town == null || event.town!.isEmpty ;
    bool address = event.address == null || event.address!.isEmpty ;
    bool state = event.state == null || event.state!.isEmpty;
    bool city = event.city == null || event.city!.isEmpty;
    bool pinCode = event.pinCode == null || event.pinCode!.length != 6;
    bool landmark = event.landMark == null || event.landMark!.isEmpty ;


    if(houseNo || town || address || state || city || pinCode || landmark){
      emit(OrderError(houseNo: houseNo,town: town,address: address,city: city,state: state,zipCode: pinCode,landmark : landmark));
      return false;
    }else{
      return true;
    }
  }
  void createOrderApi(OrderSubmitEvent event) async {
    // header
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };
    User user = await getUserPref(userProfileDataPrefecences);

    String address = '${event.placeMark?.street}, ${event.placeMark?.locality}, ${event.placeMark?.administrativeArea}, ${event.placeMark?.country}';
    String zipCode = '${event.placeMark?.postalCode}';


    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['booked_by_id'] = user.id.toString();
    body['user_type'] =  'type_marketing_ex' ;
    body['user_id'] =  event.distributorId.toString();
    body['total_amount'] = event.totalAmount;
    body['d_house_number'] = event.houseNo;
    body['d_town'] = event.town;
    body['d_address'] = event.address;
    body['d_city'] = event.city;
    body['d_state'] = event.state;
    body['d_zip_code'] = event.pinCode;
    body['d_landmark'] = event.landMark;
    if( user.roleId == '4'){
      body['latitude'] = event.locationData!.latitude.toString();
      body['longitude'] = event.locationData!.longitude.toString();
      body['current_location'] = address;
      body['zip_code'] = zipCode;
    }

    print(body);

    emit(OrderLoading());

    try {
      // request
      OrderResponse response = await orderApi(header, body);
      // handling response
      if (response.status == true && response.orderDetail != null) {
        emit(OrderSubmitSuccess(/*orderDetail: response.orderDetail!*/));
      } else {
        emit(OrderError(error: response.message.toString()));
      }
    }catch(e){
       emit(OrderError(error: e.toString()));
    }
  }
}

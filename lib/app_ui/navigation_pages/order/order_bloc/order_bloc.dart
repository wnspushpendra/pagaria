
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/modal/order/order.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderListFetchEvent>((event, emit) {
      fetchOrderApi(event);
    });
    on<OrderSubmitEvent>((event, emit) {
      createOrderApi(event);
    });
  }

  void fetchOrderApi(OrderListFetchEvent event) async{
    // header
    Map<String, String> header =  {
    "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = await getUserPref(userProfileDataPrefecences).then((value) => value.id.toString());
    body['user_type'] = 'type_marketing_ex';


    // request
    OrderListResponseModal response = await userOrderListApi(header, body);
    // handling response
    if(response.status == true && response.orderList != null){
    emit(OrderSuccess( orderList: response.orderList!));
    }else{
    emit(OrderError(error: response.message.toString()));
    }
  }

  void createOrderApi(OrderSubmitEvent event) async {
    // header
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };
    String userId = await getUserPref(userProfileDataPrefecences).then((value) => value.id.toString());

    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['booked_by_id'] = await getUserPref(userProfileDataPrefecences).then((value) => value.id.toString());
    body['user_type'] = 'type_marketing_ex';
    body['user_id'] =  event.distributorId ;
    body['total_amount'] = event.totalAmount;

    emit(OrderLoading());


    // request
    OrderResponse response = await orderApi(header, body);
    // handling response
    if(response.status == true && response.orderDetail != null){
      emit(OrderSuccess( orderDetail: response.orderDetail!));
    }else{
      emit(OrderError(error: response.message.toString()));
    }
  }
}

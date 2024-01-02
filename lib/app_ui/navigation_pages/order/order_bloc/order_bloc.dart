
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderListFetchEvent>((event, emit) {
      fetchOrderApi(event);
    });
    on<OrderCreateEvent>((event, emit) {
      createOrderApi(event);
    });
  }

  void fetchOrderApi(OrderListFetchEvent event) {}

  void createOrderApi(OrderCreateEvent event) {}
}


import 'package:webnsoft_solution/modal/order/order.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}
class OrderListFetch extends OrderState {
  String userId;
  OrderListFetch({required this.userId});
}
class OrderListFetchSuccess extends OrderState {}
class OrderSuccess extends OrderState {
  final  List<OrderList>? orderList;
  final OrderDetail? orderDetail;
  final String? userRole;
  OrderSuccess({this.orderList, this.orderDetail,this.userRole});
}
class OrderError extends OrderState {
  final String error;
  OrderError({required this.error});
}

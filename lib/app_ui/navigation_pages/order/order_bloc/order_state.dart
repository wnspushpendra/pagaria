
import 'package:webnsoft_solution/modal/order/order.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}
class OrderListFetch extends OrderState {
  String userId;
  OrderListFetch({required this.userId});
}
class OrderListFetchSuccess extends OrderState {}
class OrderSuccess extends OrderState {
  final  List<Order>? orderList;
  final OrderDetail? orderDetail;
  final String? userRole;
  OrderSuccess({this.orderList, this.orderDetail,this.userRole});
}
class OrderSubmitSuccess extends OrderState {}
class OrderError extends OrderState {
  final String? error;
  final bool? houseNo;
  final bool? town;
  final bool? address;
  final bool? city;
  final bool? state;
  final bool? zipCode;
  final bool? landmark;

  OrderError({ this.error,this.houseNo,this.town,this.city,this.state,this.address,this.zipCode,this.landmark});
}

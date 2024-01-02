
abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}
class OrderListFetch extends OrderState {
  String userId;
  OrderListFetch({required this.userId});
}
class OrderListFetchSuccess extends OrderState {}
class OrderCreatedSuccess extends OrderState {}
class OrderError extends OrderState {}

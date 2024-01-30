
abstract class OrderEvent {}

class OrderListFetchEvent extends OrderEvent{
  final String? distributorId;
  OrderListFetchEvent({this.distributorId});
}
class OrderSubmitEvent extends OrderEvent{
  final String totalAmount;
  final String distributorId;
  OrderSubmitEvent({required this.totalAmount,required this.distributorId});
}

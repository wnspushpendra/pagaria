
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_modal.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {
  List<Firm>? firmList;
  List<PaymentDetailData>? paymentDetailList;
  List<Order>? order;
  PaymentRecord? paymentRecord;
  String? totalAmount;
  String? dueAmount;
  int? paymentSuccessAmount;
  PaymentSuccess({ this.firmList,this.paymentDetailList,this.order,this.paymentRecord,this.totalAmount,this.dueAmount,this.paymentSuccessAmount});
}
class PaymentError extends PaymentState {
  final String? error;
  final bool? firmName;
  final bool? customerSelect;
  final bool? payableAmount;
  final bool? paymentOption;
  final bool? referenceNumber;
  final bool? attachment;
  PaymentError({this.error,this.firmName,this.customerSelect,this.payableAmount,this.paymentOption,this.referenceNumber,this.attachment});
}


import 'package:webnsoft_solution/modal/firm_customer_modal.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {
  List<Firm>? firmList;
  PaymentSuccess({required this.firmList});
}
class PaymentError extends PaymentState {
  final String? error;
  final bool? firmName;
  final bool? customerName;
  final bool? payableAmount;
  final bool? paymentOption;
  final bool? referenceNumber;
  final bool? attachment;
  PaymentError({this.error,this.firmName,this.customerName,this.payableAmount,this.paymentOption,this.referenceNumber,this.attachment});
}

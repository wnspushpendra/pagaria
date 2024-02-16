
import 'dart:io';

abstract class PaymentEvent {}

class FetchFirmCustomerEvent extends PaymentEvent{}
class FetchPaymentListDataEvent extends PaymentEvent{}
class FetchCustomerDueAmountEvent extends PaymentEvent{
  final String customerId;
  FetchCustomerDueAmountEvent({required this.customerId});
}

class PaymentClickEvent extends PaymentEvent{
  final String? customerId;
  final String? payableAmount;
  final String? paymentOption;
  final String? paymentReferenceNumber;
  final String path;

  PaymentClickEvent({
    required this.customerId,
    required this.payableAmount,
    required this.paymentOption,
    required this.paymentReferenceNumber,
    required this.path
});

}

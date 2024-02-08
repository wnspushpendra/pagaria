
import 'dart:io';

abstract class PaymentEvent {}

class FetchFirmCustomerEvent extends PaymentEvent{}

class PaymentClickEvent extends PaymentEvent{
  final String? firmName;
  final String? customerName;
  final String? payableAmount;
  final String? paymentOption;
  final String? paymentReferenceNumber;
  final File? file;

  PaymentClickEvent({
    required this.firmName,
    required this.customerName,
    required this.payableAmount,
    required this.paymentOption,
    required this.paymentReferenceNumber,
    required this.file
});

}

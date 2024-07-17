
import 'dart:convert';
import 'dart:io';

import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/payment/due_payment_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_modal.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

/// * Firm list api for marketing executive
Future<FirmCustomerResponseModal> firmCustomerListData(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + firmCustomerListApi),
      headers: header,
      body: body);
  FirmCustomerResponseModal apiResponse = FirmCustomerResponseModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * customer due payment api for marketing executive
Future<CustomerDueAmountModal> dueAmountData(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + dueAmountApi),
      headers: header,
      body: body);
  CustomerDueAmountModal apiResponse = CustomerDueAmountModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * customer  payment api for marketing executive
Future<PaymentListModal> customerPaymentListData(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + paymentList),
      headers: header,
      body: body);
  PaymentListModal apiResponse = PaymentListModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * customer  payment api for marketing executive
///
Future<CustomerPaymentModal> customerPaymentData(String imagePath,Map<String, String> header, Map<String, dynamic> body) async {

  var request = http.MultipartRequest('POST', Uri.parse(baseUrl+paymentApi));
  request.headers.addAll(header);

  if(imagePath.isNotEmpty){
    // multipart for getting image from path
    var image = await http.MultipartFile.fromPath('image', imagePath);
    request.files.add(image);
  }
  // sending value data
  body.forEach((key, value) {
    request.fields[key] = value.toString();
  });

  /*** send payment request  */
  var response = await request.send();
  var responseData = await response.stream.bytesToString();
  CustomerPaymentModal userData = CustomerPaymentModal.fromJson(json.decode(responseData));
  return userData;
}



/// * distributor order payment api
///
Future<CustomerPaymentModal> distributorOrderPayment(String imagePath,Map<String, String> header, Map<String, dynamic> body) async {

  var request = http.MultipartRequest('POST', Uri.parse(baseUrl+paymentForOrderApi));
  request.headers.addAll(header);

  if(imagePath.isNotEmpty){
    // multipart for getting image from path
    var image = await http.MultipartFile.fromPath('image', imagePath);
    request.files.add(image);
  }
  // sending value data
  body.forEach((key, value) {
    request.fields[key] = value.toString();
  });

  /*** send payment request  */
  var response = await request.send();
  var responseData = await response.stream.bytesToString();
  CustomerPaymentModal userData = CustomerPaymentModal.fromJson(json.decode(responseData));
  return userData;
}

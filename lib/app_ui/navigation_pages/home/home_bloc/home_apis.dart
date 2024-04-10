

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/check_in_status.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/checkin_checkout.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';



/// * api for update user fcm token
Future<UserResponse> userTokenAndDevice(Map<String, String> header, Map<String, dynamic> map) async {
  var response = await http.post(Uri.parse(baseUrl + updateDeviceTokenApi),
      headers: header,
      body: map);
  UserResponse apiResponse = UserResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}



/// *  get check in status api for login user
Future<CheckInDetails> checkInDetailsApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + checkInStatusApi),
      headers: header,
      body: body);
  CheckInDetails apiResponse = CheckInDetails.fromJson(jsonDecode(response.body));
  return apiResponse;
}
/// *  check In-checkOut update api for login user
Future<CheckInCheckOutResponse> checkInOutUpdateApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + checkInOutApi),
      headers: header,
      body: body);
  CheckInCheckOutResponse apiResponse = CheckInCheckOutResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}


/// * distributor list api for login user
Future<DistributorListResponse> distributorListApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + customerListApi),
      headers: header,
      body: body);
  DistributorListResponse apiResponse = DistributorListResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
/// * distributor list api for login user
Future<DistributorPaymentModal> distributorPayments(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + distributorPaymentsApi),
      headers: header,
      body: body);
  DistributorPaymentModal apiResponse = DistributorPaymentModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}
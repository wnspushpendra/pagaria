
import 'dart:convert';

import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';

/// * Firm list api for marketing executive
Future<FirmCustomerResponseModal> firmCustomerListData(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + firmCustomerListApi),
      headers: header,
      body: body);
  FirmCustomerResponseModal apiResponse = FirmCustomerResponseModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

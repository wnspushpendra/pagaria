
import 'dart:convert';

import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:http/http.dart' as http;

/// * Firm list api for marketing executive
Future<CartProductResponseModal> firmListDataApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + firmListApi),
      headers: header,
      body: body);
  CartProductResponseModal apiResponse = CartProductResponseModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_detail.dart';

/// * product details api for login user
Future<ProductDetailResponse> productDetailApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + productDetailsApi),
      headers: header,
      body: body);
  ProductDetailResponse apiResponse = ProductDetailResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

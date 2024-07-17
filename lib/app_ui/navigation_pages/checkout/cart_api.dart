

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/cart/cart_item_count.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/cart/update_cart_qty.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_detail.dart';

/// * cart list api for login user
Future<CartProductResponseModal> cartListDataApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + cartListApi),
      headers: header,
      body: body);
  CartProductResponseModal apiResponse = CartProductResponseModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * update cart product quantity api
Future<UpdateCartQuantityResponseModal> updateCartQtyApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + updateProductQtyApi),
      headers: header,
      body: body);
  UpdateCartQuantityResponseModal apiResponse = UpdateCartQuantityResponseModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}


/// * cart list api for login user
Future<CartCountModal> cartCountApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + cartItemCountApi),
      headers: header,
      body: body);
  CartCountModal  apiResponse = CartCountModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}


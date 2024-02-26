

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/cart/remove_cart_item.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/order/order.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/modal/product_list.dart';

/// * order api
Future<OrderResponse> orderApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + submitOrderApi),
      headers: header,
      body: body);
  OrderResponse apiResponse = OrderResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * order list
Future<UserRoleOrderModal> userOrderListApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + orderListApi),
      headers: header,
      body: body);
  UserRoleOrderModal apiResponse = UserRoleOrderModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}


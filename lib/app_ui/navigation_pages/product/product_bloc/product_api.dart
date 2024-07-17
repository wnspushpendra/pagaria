

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/cart/remove_cart_item.dart';
import 'package:webnsoft_solution/modal/product_list.dart';

/// * product api for login user
Future<ProductListResponse> productApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + productListApi),
      headers: header,
      body: body);
  ProductListResponse apiResponse = ProductListResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * add product into cart
Future<AddProductCartResponse> addCartApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + addToCartProductApi),
      headers: header,
      body: body);
  AddProductCartResponse apiResponse = AddProductCartResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * remove product into cart
Future<RemoveCartItemModal> removeFromCartApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + removeFromCartProductApi),
      headers: header,
      body: body);
  RemoveCartItemModal apiResponse = RemoveCartItemModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

/// * delete cart
Future<RemoveCartItemModal> deleteCartRequest(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + deleteCartApi),
      headers: header,
      body: body);
  RemoveCartItemModal apiResponse = RemoveCartItemModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}

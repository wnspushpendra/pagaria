

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';

/// * category api for login user
Future<CategoryListResponse> categoryApi(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + categoryListApi),
      headers: header,
      body: body);
  CategoryListResponse apiResponse = CategoryListResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

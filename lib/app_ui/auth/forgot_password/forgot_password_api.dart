import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';


Future<UserResponse> forgotPasswordStatus(Map<String, String> header, Map<String, dynamic> map) async {
  var response = await http.post(Uri.parse("$baseUrl$forgotPasswordApi"), headers: header, body: map);
  UserResponse apiResponse = UserResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}


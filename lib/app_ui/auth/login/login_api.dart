

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';

/// * api for login user
Future<UserResponse> userLoginStatus(Map<String, dynamic> map) async {
  var response = await http.post(Uri.parse(baseUrl + loginApi),
      body: map);
  UserResponse apiResponse = UserResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}




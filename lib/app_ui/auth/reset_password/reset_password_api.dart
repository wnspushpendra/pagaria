import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';



/// * api call for reset password
Future<UserResponse> resetPasswordStatus(Map<String, String> header, Map<String, String> map, int id) async {
  var response = await http.post(Uri.parse("$baseUrl$resetPasswordApi"), headers: header, body: map);
  UserResponse apiResponse = UserResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}


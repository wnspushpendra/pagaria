

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';

Future<MarketingExecutiveLoginResponse> userLoginStatus(Map<String, dynamic> map) async {
  var response = await http.post(Uri.parse(baseUrl + loginApi),
      body: map);
  MarketingExecutiveLoginResponse apiResponse = MarketingExecutiveLoginResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

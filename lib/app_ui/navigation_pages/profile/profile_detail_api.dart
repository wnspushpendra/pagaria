
import 'dart:convert';

import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/modal/profile_detail.dart';

Future<ProfileDetailResponse> fetchProfileDetailsStatus(Map<String, String> header, Map<String, dynamic> map) async {
  var response = await http.post(Uri.parse(baseUrl + profileDetailApi),
      headers: header,
      body: map);
  ProfileDetailResponse apiResponse = ProfileDetailResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
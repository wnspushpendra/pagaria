
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/executive/target_modal.dart';

/// *  get check in status api for login user
Future<TargetModal> targetData(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + targetApi),
      headers: header,
      body: body);
  TargetModal apiResponse = TargetModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}
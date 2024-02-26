import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/executive/my_activity_modal/my_activity_modal.dart';

/// * my activity api
Future<MyActivityModal> myActivity(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + myActivityApi),
      headers: header,
      body: body);
  MyActivityModal apiResponse = MyActivityModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}
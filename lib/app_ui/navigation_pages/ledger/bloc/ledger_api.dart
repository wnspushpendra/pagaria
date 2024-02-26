

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/ledger/ledger_modal.dart';


/// * ledger api
Future<LedgerModal> ledgerDataRequest(Map<String, String> header, Map<String, dynamic> body) async {
  var response = await http.post(Uri.parse(baseUrl + ledgerApi),
      headers: header,
      body: body);
  LedgerModal apiResponse = LedgerModal.fromJson(jsonDecode(response.body));
  return apiResponse;
}





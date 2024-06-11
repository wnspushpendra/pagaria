
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_state.dart';
import 'package:webnsoft_solution/modal/ledger/ledger_modal.dart';
import 'package:webnsoft_solution/modal/ledger/ledger_pdf_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';
import 'package:http/http.dart' as http;

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  LedgerBloc() : super(LedgerLoading()) {
    on<LedgerFetchEvent>((event, emit) => ledgerData(event));
    on<LedgerDownloadEvent>((event, emit) => ledgerDownload(event));
  }

  ledgerData(LedgerFetchEvent event) async {
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = event.distributorId;
    body['user_type'] = 'type_marketing_ex';

    try {
      LedgerModal response = await ledgerDataRequest(await ChangeRoutes.getHeaders(), body);
      if (response.status == true && response.ledger != null && response.ledger!.isNotEmpty) {
        emit(LedgerSuccess(ledgerList: response.ledger!,
            ledgerTotal: response.totalAmount!,
            ledgerPendingTotal: response.dueAmount.toString()));
      } else {
        emit(LedgerError(error: response.message.toString()));
      }
    }catch(e){
      emit((LedgerError(error: e.toString())));
    }
  }

   ledgerDownload(LedgerDownloadEvent event) async {
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };
    User user = await getUser();

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = event.distributorId.toString();
    body['user_type'] = 'type_marketing_ex';

    final response = await http.post(Uri.parse(baseUrl+ledgerDownloadApi),headers: header,body: body);
    LedgerPdfModal apiResponse = LedgerPdfModal.fromJson(jsonDecode(response.body));
    if(apiResponse.status == true){
      emit(LedgerDownloadSuccess(url: apiResponse.pdfUrl));
    }else{
      emit((LedgerError(error: apiResponse.message.toString())));
    }


   /* if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = File('$tempPath/MyLedger.pdf');
      await file.writeAsBytes(response.bodyBytes);
      emit(LedgerDownloadSuccess(file: file));
    } else {
      emit((LedgerError(error: 'Failed to load PDF')));
      throw Exception('Failed to load PDF');
      return null;

    }*/

  }
}

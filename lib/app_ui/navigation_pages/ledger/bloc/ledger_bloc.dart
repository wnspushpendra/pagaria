
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_state.dart';
import 'package:webnsoft_solution/modal/ledger/ledger_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  LedgerBloc() : super(LedgerLoading()) {
    on<LedgerFetchEvent>((event, emit) => ledgerData(event));
  }

  ledgerData(LedgerFetchEvent event) async {
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = event.distributorId;
    body['user_type'] = 'type_marketing_ex';

    LedgerModal response = await ledgerDataRequest(header,body);

    if(response.status == true && response.ledger != null && response.ledger!.isNotEmpty){
     emit( LedgerSuccess(ledgerList : response.ledger!,ledgerTotal: response.totalAmount!,ledgerPendingTotal: response.dueAmount.toString()!));
    }else{
      emit(LedgerError(error : response.message.toString()));
    }





  }
}

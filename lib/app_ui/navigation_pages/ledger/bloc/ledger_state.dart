
import 'dart:io';

import 'package:webnsoft_solution/modal/ledger/ledger_modal.dart';

abstract class LedgerState {}

class LedgerLoading extends LedgerState {}
class LedgerSuccess extends LedgerState {
  List<Ledger> ledgerList;
  String ledgerTotal;
  String ledgerPendingTotal;
  LedgerSuccess({required this.ledgerList,required this.ledgerTotal,required this.ledgerPendingTotal});
}
class LedgerError extends LedgerState {
  String error;
  LedgerError({required this.error});
}

class LedgerDownloadSuccess extends LedgerState {
  File? file;
  String? url;
  LedgerDownloadSuccess({ this.file,this.url});
}

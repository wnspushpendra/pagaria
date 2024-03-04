
abstract class LedgerEvent {}
 class LedgerFetchEvent extends  LedgerEvent {
 final String distributorId;
 LedgerFetchEvent({required this.distributorId});
 }

class LedgerDownloadEvent extends  LedgerEvent {
 final String distributorId;
 LedgerDownloadEvent({required this.distributorId});
}

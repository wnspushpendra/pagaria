
abstract class LedgerEvent {}
 class LedgerFetchEvent extends  LedgerEvent {
 final String distributorId;
 LedgerFetchEvent({required this.distributorId});
 }

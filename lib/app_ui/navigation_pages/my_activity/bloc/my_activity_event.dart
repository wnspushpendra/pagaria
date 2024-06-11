abstract class MyActivityEvent {}

class FetchMyActivityEvent extends MyActivityEvent {
  bool? fromShopVisit;
  FetchMyActivityEvent({this.fromShopVisit});
}

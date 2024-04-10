
import 'package:geocoding_platform_interface/src/models/placemark.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

abstract class HomeEvent {}

class FirebaseTokenEvent extends HomeEvent{}
class HomeTargetFetchEvent extends HomeEvent{}
class HomeCheckInStatusEvent extends HomeEvent{}
class HomeCheckInOutUpdateEvent extends HomeEvent{
  final String checkInOutStatus;
  final LocationData locationData;
  final Placemark? placeMark;
  HomeCheckInOutUpdateEvent({required this.checkInOutStatus, required  this.locationData, required this.placeMark});
}
class HomeCustomerFetchEvent extends HomeEvent{}

// distributor fetch payment history
class HomeFetchDistributorPaymentEvent extends HomeEvent{}



import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

abstract class OrderEvent {}

class OrderListFetchEvent extends OrderEvent{
  final String? distributorId;
  OrderListFetchEvent({this.distributorId});
}
class OrderSubmitEvent extends OrderEvent{
  final String totalAmount;
  final String distributorId;
  final LocationData locationData;
  final Placemark? placeMark;

  OrderSubmitEvent({required this.totalAmount,required this.distributorId,required this.locationData,required this.placeMark});
}

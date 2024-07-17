
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

abstract class OrderEvent {}

class OrderListFetchEvent extends OrderEvent{
  final String? distributorId;
  final bool? fromMenu;
  OrderListFetchEvent({this.distributorId,this.fromMenu});
}
class OrderSubmitEvent extends OrderEvent{
  final String totalAmount;
  final String distributorId;
  final LocationData? locationData;
  final Placemark? placeMark;
  final String? pinCode;
  final String? houseNo;
  final String? town;
  final String? address;
  final String? city;
  final String? state;
  final String? landMark;



  OrderSubmitEvent({required this.totalAmount,required this.distributorId,required this.locationData,required this.placeMark,required this.pinCode,required this.houseNo,required this.town,required this.address,required this.city,required this.state,required this.landMark});
}

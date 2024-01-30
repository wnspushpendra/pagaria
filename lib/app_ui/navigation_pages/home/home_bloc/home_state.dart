
import 'package:webnsoft_solution/modal/checkin_checkout/check_in_status.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/checkin_checkout.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}
class HomeCheckInOutLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final List<Customer>? distributorList;
  final CheckInData? checkInData;
  final CheckInOutRecord? checkInOutRecord;


  HomeSuccess({ this.distributorList,this.checkInData,this.checkInOutRecord});
}
class HomeCheckInStatusSuccess extends HomeState {
  final CheckInData checkInData;
  HomeCheckInStatusSuccess({required this.checkInData});
}
class HomeCheckInOutSuccess extends HomeState {
  final CheckInOutRecord checkInOutRecord;
  HomeCheckInOutSuccess({required this.checkInOutRecord});
}
class HomeError extends HomeState {
  String error;
  HomeError({required this.error});
}

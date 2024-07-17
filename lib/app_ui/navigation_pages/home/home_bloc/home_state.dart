
import 'package:webnsoft_solution/modal/checkin_checkout/check_in_status.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/checkin_checkout.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor/distributor_order_modal.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}
class HomeCheckInOutLoading extends HomeState {}
class HomeSuccess extends HomeState {
 // final List<Customer>? distributorList;
 final List<User>? distributorList;
  final CheckInData? checkInData;
  final CheckInOutRecord? checkInOutRecord;
  final List<DistributorPayment>? recentOrderList;
  final List<DistributorPayment>? pendingOrderList;
  final List<DistributorPayment>? completedOrderList;
  final bool? fromShopCheckIn;



  HomeSuccess({ this.distributorList,this.checkInData,this.checkInOutRecord,this.recentOrderList,this.pendingOrderList,this.completedOrderList,this.fromShopCheckIn});
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
class HomeCheckInOurError extends HomeState {
  String error;
  HomeCheckInOurError({required this.error});
}

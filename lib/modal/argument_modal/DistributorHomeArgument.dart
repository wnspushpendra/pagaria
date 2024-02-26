import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor/distributor_order_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';

class DistributorHomeArgument{
  String status;
  List<DistributorPayment> orderList;

  DistributorHomeArgument({required this.status,required this.orderList});



}
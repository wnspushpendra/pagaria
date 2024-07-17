import 'package:flutter/material.dart';
import 'package:webnsoft_solution/modal/argument_modal/DistributorPaymentArgument.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/argument_modal/ProductArgument.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class ChangeRoutes{

// getting header
  static Future<Map<String, String>> getHeaders() async {
    String userToken = await getStringPref(userTokenPrefecences);
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
    };
    return headers;
  }

  /// * get user data shared preference
  static Future<User> getUser() async{
    return await getUserPref(userProfileDataPrefecences);
  }

  /// * get user id shared preference
  static Future<String> getUserId() async {
    User user = await getUser();
    return user.id.toString();
  }

  static openLoginScreen(BuildContext context) async{
    Navigator.pushReplacementNamed(context, loginRoute,);
  }

  static unAuthorizedError(BuildContext context,String? error) {
    if(error != null && error.isNotEmpty && error == unAuthorization){
      openLoginScreen(context);
    }
  }



  // back user home screen
  static Future<void> openHomeScreen(BuildContext context,User user) async{
    Navigator.pushReplacementNamed(context, user.roleId == '4' ? homeRoute :homeDistributorRoute, arguments: user);
  }
  // back user home screen
  static Future<void> openNotificationScreen(BuildContext context) async{
    Navigator.pushReplacementNamed(context, notificationRoute);
  }

  static openProfileScreen(BuildContext context, User user) async{
    Navigator.pushReplacementNamed(context, profileRoute,arguments: user);
  }
  static openMyActivityScreen(BuildContext context) async{
    Navigator.pushReplacementNamed(context, myActivityRoute,);
  }
  static openMyVisitScreen(BuildContext context) async{
    Navigator.pushReplacementNamed(context, myVisitRoute,);
  }
  static openResetPasswordScreen(BuildContext context) async{
    Navigator.pushReplacementNamed(context, resetPasswordRoute,arguments: await getUser());
  }
  static openProductScreen(BuildContext context, User user,User? distributor/*String? distributorId*/) async{
    Navigator.pushReplacementNamed(context, productRoute,arguments:  user.roleId =='5' ? user : distributor);
  }

  static openProductDetailScreen(BuildContext context,ProductArgument argument){
    Navigator.pushReplacementNamed(context, productDetailRoute, arguments : argument);
  }

  static openCheckOutScreen(BuildContext context,User? user){
    Navigator.pushReplacementNamed(context, checkOutRoute, arguments: user );
  }
 //   Navigator.pushReplacementNamed(context, checkOutRoute, arguments: widget.distributorId  }
  static openCustomerScreen(BuildContext context,String? id){
    Navigator.pushReplacementNamed(context, customerListRoute);
  }
  static openCustomerDetailsScreen(BuildContext context,String? id){
    Navigator.pushReplacementNamed(context, paymentRoute,arguments: id);
  }
  static openOrderScreen(BuildContext context,bool? value){
    Navigator.pushReplacementNamed(context, orderRoute,arguments: value);
  }
  static openOrderDetailScreen(BuildContext context,Order order){
    Navigator.pushReplacementNamed(context, orderDetailRoute,arguments: order);
  }

  static openExecutivePaymentScreen(BuildContext context,User user){
    Navigator.pushReplacementNamed(context,user.roleId == '4' ?  paymentRoute : distributorPaymentRoute ,arguments:user.roleId == '4' ? null: user.id.toString() );
  }
  static openDistributorPaymentScreen(BuildContext context,DistributorPaymentArgument argument ){
    Navigator.pushReplacementNamed(context, distributorOrderPaymentRoute,arguments: argument);
  }

  static openPaymentDetailScreen(BuildContext context, PaymentDetailData paymentDetail,){
    Navigator.pushReplacementNamed(context, paymentDetailRoute,arguments: paymentDetail);
  }
  static openLedgerPaymentScreen(BuildContext context,String? id){
    Navigator.pushReplacementNamed(context, paymentRoute,arguments: id);
  }
  static openCustomerForOrderScreen(BuildContext context){
    Navigator.pushReplacementNamed(context, customerForOrderRoute);
  }
  static openLedgerScreen(BuildContext context,String userId, bool fromDistributor){
    Navigator.pushReplacementNamed(context, ledgerRoute,arguments: LedgerArgument(distributorId:  userId,showAppbar: true,fromDistributor: true));  }

}
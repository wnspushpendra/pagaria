
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/cart/update_cart_qty.dart';

abstract class CheckOutState {}

class CheckOutInitial extends CheckOutState {}
class CheckOutLoading extends CheckOutState {}
class CheckOutUpdateQtyLoading extends CheckOutState {}
class CheckOutSuccess extends CheckOutState {
 final List<CartItem>? cartList;
 final String? productAmount;
 final CartItem? cartItem;
 final String? cartTotal;
 final int? cartItemCount;
 final String? userRole;


  CheckOutSuccess({this.cartList, this.productAmount,this.cartItem,this.cartTotal,this.cartItemCount,this.userRole});
}
class CheckOutError extends CheckOutState {
  final String error;
  CheckOutError({required this.error});
}

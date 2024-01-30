
abstract class CheckOutEvent {}
 class CheckOutListEvent extends CheckOutEvent {}
 class CheckOutUpdateQuantityEvent extends CheckOutEvent {
 String productQty;
 String cartItemId;
 CheckOutUpdateQuantityEvent({required this.productQty, required this.cartItemId,});
 }
 class CheckOutRemoveItemEvent extends CheckOutEvent {
 final String cartItemId;
 CheckOutRemoveItemEvent({required this.cartItemId});
 }

abstract class ProductEvent {}


 class AddProductCartEvent extends ProductEvent {
  final String productId;
  AddProductCartEvent({required this.productId});
 }
 class RemoveProductCartEvent extends ProductEvent {
  final String cartItemId;
  RemoveProductCartEvent({required this.cartItemId});
 }
 class DeleteCartEvent extends ProductEvent {}

class ProductLoadEvent extends ProductEvent {
  final String categoryId;
  ProductLoadEvent({required this.categoryId});
}

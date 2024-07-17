
abstract class ProductDetailsEvent {}
class ProductDetailsLoadEvent extends ProductDetailsEvent{
  String productId;
  ProductDetailsLoadEvent({required this.productId});
}

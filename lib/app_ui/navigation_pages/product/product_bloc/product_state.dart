
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/product_list.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductSuccess extends ProductState {
  List<Product> productList;
  ProductSuccess({required this.productList });
}
class CartProductAddSuccess extends ProductState {
  CartProduct cartProduct;
  CartProductAddSuccess({required this.cartProduct });
}
class CartProductRemoveSuccess extends ProductState {
  String message;
  CartProductRemoveSuccess({required this.message });
}

class ProductError extends ProductState {
  final String error;
  ProductError({required this.error});
}

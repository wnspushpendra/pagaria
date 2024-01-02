
abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductSuccess extends ProductState {
  List<String> productList;
  ProductSuccess({required this.productList});
}
class ProductError extends ProductState {
  final String error;
  ProductError({required this.error});
}

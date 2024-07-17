
import 'package:webnsoft_solution/modal/product_detail.dart';

abstract class ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}
class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetails productDetails;
  final List<Productgallery> productGallery;
  ProductDetailsSuccess({required this.productDetails,required this.productGallery });
}
class ProductDetailsError extends ProductDetailsState {
  String error;
  ProductDetailsError({required this.error});
}

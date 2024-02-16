import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_list.dart';

class ProductArgument{
  String productId;
  String? distributorId;
  Product? product;
  Product? totalAmount;
  ProductArgument({required this.productId, this.distributorId,this.product,this.totalAmount});


}
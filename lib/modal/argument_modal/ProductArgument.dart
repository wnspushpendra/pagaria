import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_list.dart';

class ProductArgument{
  String productId;
  User? distributor;
  Product? product;
  Product? totalAmount;
  ProductArgument({required this.productId, this.distributor,this.product,this.totalAmount});


}
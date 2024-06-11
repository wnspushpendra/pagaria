

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';
import 'package:webnsoft_solution/modal/cart/add_cart_product.dart';
import 'package:webnsoft_solution/modal/cart/remove_cart_item.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) => loadProductList(event));
    on<AddProductCartEvent>((event, emit) => addToCart(event));
    on<RemoveProductCartEvent>((event, emit) => removeFromCart(event));
    on<DeleteCartEvent>((event, emit) => deleteCartEvent(event));
  }

  void loadProductList(ProductLoadEvent event) async{
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['category_id'] = event.categoryId;
    body['user_id'] = user.id.toString();
    body['user_type'] =  'type_marketing_ex' ;

    emit(ProductLoading());

    try {
      ProductListResponse response = await productApi(header, body);
      if (response.status == true && response.productList != null) {
        emit(ProductSuccess(
            productList: response.productList!, userRole: user.roleId));
      } else {
        emit(ProductError(error: response.message.toString()));
      }
    }catch(e){
      emit(ProductError(error: e.toString()));
    }


  }
  void addToCart(AddProductCartEvent event) async{
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['cart_user_id'] = user.id.toString();
    body['product_id'] = event.productId;
    body['user_type'] =  'type_marketing_ex';

    emit(CartProductRemoveLoading());

try {
  AddProductCartResponse response = await addCartApi(header, body);
  if (response.status == true && response.cartProduct != null) {
    emit(CartProductAddSuccess(cartProduct: response.cartProduct!));
  } else {
    emit(ProductError(error: response.message.toString()));
  }
}catch(e){
  emit(ProductError(error: e.toString()));
}
  }
  void removeFromCart(RemoveProductCartEvent event) async{
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['cart_item_id'] = event.cartItemId.toString();

    //emit(ProductLoading());
try {
  RemoveCartItemModal response = await removeFromCartApi(header, body);
  if (response.status == true && response.cartItemId != null) {
    emit(CartProductRemoveSuccess(message: response.cartItemId!));
  } else {
    emit(ProductError(error: response.message.toString()));
  }
}catch(e){
  emit(ProductError(error: e.toString()));
}

  }

  void deleteCartEvent(DeleteCartEvent event) async{
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['cart_user_id'] = user.id.toString();
    body['user_type'] = 'type_marketing_ex';

    //emit(ProductLoading());
    try {
      RemoveCartItemModal response = await deleteCartRequest(header, body);
      if (response.status == true ) {
        emit(CartDeleteSuccess(message: response.message!));
      } else {
        emit(ProductError(error: response.message.toString()));
      }
    }catch(e){
      emit(ProductError(error: e.toString()));
    }

  }
}

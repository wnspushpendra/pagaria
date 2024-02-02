
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/bloc/check_out_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/cart_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/modal/cart/cart_item_count.dart';
import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';
import 'package:webnsoft_solution/modal/cart/remove_cart_item.dart';
import 'package:webnsoft_solution/modal/cart/update_cart_qty.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(CheckOutInitial()) {
    on<CheckOutListEvent>((event, emit) {checkOutListApi(event);});
    on<CheckOutUpdateQuantityEvent>((event, emit) {checkOutUpdateQuantity(event);});
    on<CartItemCountEvent>((event, emit) {cartItemCount(event);});
  }

  checkOutListApi(CheckOutListEvent event) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user data from preference      ****************/
    User user = await getUserPref(userProfileDataPrefecences);

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = user.id.toString();
    body['user_type'] = user.roleId == '4' ? 'type_marketing_ex' : 'type_customer';

    CartProductResponseModal response = await cartListDataApi(header, body);

    if(response.status == true && response.cartItem != null){
      emit(CheckOutSuccess(cartList : response.cartItem!,productAmount: response.productAmount.toString()));
    }else{
      emit(CheckOutError(error: response.message.toString()));
    }
  }

  void checkOutUpdateQuantity(CheckOutUpdateQuantityEvent event) async {
    // header
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['cart_item_id'] = event.cartItemId;
    body['productQty'] = event.productQty;
    body['user_type'] = 'type_marketing_ex';

    // request
    UpdateCartQuantityResponseModal response = await updateCartQtyApi(header, body);
    // handling response
    if(response.status == true && response.updateCartItem != null){
      emit(CheckOutSuccess(cartItem : response.updateCartItem!));
    }else{
      emit(CheckOutError(error: response.message.toString()));
    }
  }

  void cartItemCount(CartItemCountEvent event) async {
    // header
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };
    User user = await getUserPref(userProfileDataPrefecences);

    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = user.id.toString();
    body['user_type'] = user.roleId =='4' ? 'type_marketing_ex' : 'type_customer';

    // request
    CartCountModal response = await cartCountApi(header, body);
    // handling response
    if(response.status == true && response.cartItemCount != null){
      emit(CheckOutSuccess(cartItemCount : response.cartItemCount!));
    }else{
      emit(CheckOutError(error: response.message.toString()));
    }
  }



}

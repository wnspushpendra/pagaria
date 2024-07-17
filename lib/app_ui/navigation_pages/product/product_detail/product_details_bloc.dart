
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_detail_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_detail.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsLoading()) {
    on<ProductDetailsLoadEvent>((event, emit) => loadProductDetailApi(event));
  }

  loadProductDetailApi(ProductDetailsLoadEvent event) async {

    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);


    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> body = <String, dynamic>{};
    body['product_id'] = event.productId;

    ProductDetailResponse response = await productDetailApi(header, body);

    if(response.status == true && response.productDetail != null){
      emit(ProductDetailsSuccess(productDetails : response.productDetail!,productGallery : response.productgallery!));
    }else{
      emit(ProductDetailsError(error: response.message.toString()));
    }

  }
}

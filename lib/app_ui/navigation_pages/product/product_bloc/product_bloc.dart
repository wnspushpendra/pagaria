

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) {
      loadProductList(event,emit);
    });
  }

  void loadProductList(ProductLoadEvent event, Emitter<ProductState> emit) {

  }
}

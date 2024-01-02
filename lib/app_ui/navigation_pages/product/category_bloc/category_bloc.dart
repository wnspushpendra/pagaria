
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<CategoryLoadEvent>((event, emit) {
      loadCategoryApi(event,emit);
    });
  }

  void loadCategoryApi(CategoryLoadEvent event, Emitter<CategoryState> emit) async {}
}

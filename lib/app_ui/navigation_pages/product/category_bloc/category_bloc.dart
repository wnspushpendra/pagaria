import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_state.dart';
import 'package:webnsoft_solution/modal/category_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<CategoryLoadEvent>((event, emit) {
      loadCategoryApi(event);
    });
  }

  void loadCategoryApi(
    CategoryLoadEvent event,
  ) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = user.id.toString();
    body['user_type'] = 'type_marketing_ex';
    body['admin_id'] = '16';

    emit(CategoryLoading());

    try {
      CategoryListResponse response = await categoryApi(header, body);
      if (response.status == true) {
        if (response.categoryList == null || response.categoryList!.isEmpty) {
          emit(CategoryError(error: response.message!));
        } else {
          emit(CategorySuccess(categoryList: response.categoryList!));
        }
      } else {
        emit(CategoryError(error: response.message.toString()));
      }
    } catch (e) {
      emit(CategoryError(error: e.toString()));
    }
  }
}


import 'package:webnsoft_solution/modal/category_list.dart';

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}
class CategorySuccess extends CategoryState {
  List<Categories> categoryList;
  CategorySuccess({required this.categoryList });
}
class CategoryError extends CategoryState {
  String error;
  CategoryError({required this.error});
}

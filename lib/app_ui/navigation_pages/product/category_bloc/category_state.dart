
abstract class CategoryState {}

class CategoryLoading extends CategoryState {}
class CategorySuccess extends CategoryState {
  List<String> categoryList;
  CategorySuccess({required this.categoryList});
}
class CategoryError extends CategoryState {}

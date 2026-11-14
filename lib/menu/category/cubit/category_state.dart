part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
   String msg;
   ModelCategoryList categoryDict;
  CategoryLoaded({required this.msg, required this.categoryDict});
}

class CategoryAddLoaded extends CategoryState {
  String msg;
  ModelAddCategory categoryDict;
  CategoryAddLoaded({required this.msg, required this.categoryDict});
}

class CategoryError extends CategoryState {
  final String error;
  CategoryError({required this.error});
}

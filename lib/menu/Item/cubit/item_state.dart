part of 'item_cubit.dart';

@immutable
abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  String msg;
  ModelItemList itemDict;

  ItemLoaded({
    required this.msg,
    required this.itemDict,
  });
}

class ItemAddLoaded extends ItemState {
  String msg;
  ModelAddItems itemDict;

  ItemAddLoaded({
    required this.msg,
    required this.itemDict,
  });
}

class ItemDeleteLoaded extends ItemState {
  String msg;

  ItemDeleteLoaded({
    required this.msg,
  });
}

class ItemImageLoaded extends ItemState {
  String? imagePath;
  ItemImageLoaded({this.imagePath});
}

class VarientImageLoaded extends ItemState {
  String? imagePath;
  VarientImageLoaded({this.imagePath});
}

class ItemError extends ItemState {
  final String error;

  ItemError({required this.error});
}


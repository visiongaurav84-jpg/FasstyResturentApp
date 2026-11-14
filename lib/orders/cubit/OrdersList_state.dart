part of 'ordersList_cubit.dart';

@immutable
sealed class OrdersListState {}

final class OrdersListInitial extends OrdersListState {}

final class OrdersListLoading extends OrdersListState {}

final class OrdersListLoaded extends OrdersListState {
  final ModelOrderList orderListData;

  OrdersListLoaded({
    required this.orderListData,
  });
}

final class OrdersListError extends OrdersListState {
  final String error;

  OrdersListError({required this.error});
}


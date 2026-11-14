import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../model/order/modelOrdersList.dart';
import '../repo/OrdersListRepo.dart';
part 'OrdersList_state.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  OrdersListCubit() : super(OrdersListInitial());

  final repo =
  OrdersListRepo(networkRequest: NetworkRequest());

  Future<void> getOrderSList() async {
   emit(OrdersListLoading());

    final res = await repo.getAllOrdersAPI();

   if (res.isSuccess && res.resObject?.data != null) {
     emit(
       OrdersListLoaded(orderListData: res.resObject!),
     );
   } else {
     emit(
       OrdersListError(error: res.resObject?.message ?? "Orders load failed"),
     );
   }
  }


}

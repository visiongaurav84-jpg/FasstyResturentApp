import 'package:fassty_resturents_app/model/order/modelOrdersList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../helper/app_utilities/app_theme.dart';
import '../helper/app_utilities/method_utils.dart';
import '../helper/custom_widgets/app_circular_loader.dart';
import 'cubit/ordersList_cubit.dart';
import 'order_details_screen.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  late OrdersListCubit _cubit;

  List<ModelOrderListData> allOrders = [];

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OrdersListCubit>();
    _cubit.getOrderSList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // ✅ MUST MATCH TAB COUNT
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Orders"),
          bottom: TabBar(
            isScrollable: true, // ✅ SCROLLABLE TABS
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Accepted"),
              Tab(text: "Preparing"),
              Tab(text: "Delivered"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: BlocConsumer<OrdersListCubit, OrdersListState>(
          listener: (context, state) {
            if (state is OrdersListError) {
              MethodUtils.toast(state.error);
            }
            if (state is OrdersListLoaded) {
              allOrders = state.orderListData.data ?? [];
            }
          },
          builder: (context, state) {
            if (state is OrdersListLoading) {
              return const AppLoaderProgress();
            }

            if (state is OrdersListLoaded && allOrders.isEmpty) {
              return const Center(child: Text("No orders found"));
            }

            return _body();
          },
        ),
      ),
    );
  }

  Widget _body() {
    return TabBarView(
      children: [
        _ordersList("0"),
        _ordersList("1"),
        _ordersList("2"),
        _ordersList("3"),
        _ordersList("4"),
      ],
    );
  }

  Widget _ordersList(String status) {
    print("Order Status: $status");
    final filteredOrders = allOrders
        .where((order) => order.orderStatus.toString() == status)
        .toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Text(
          "No $status orders",
          style: GoogleFonts.poppins(),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      itemBuilder: (_, index) {
        final order = filteredOrders[index];

        return _orderCard(
          context,
          orderDetails: order,
        );
      },
    );
  }

  Widget _orderCard(
      BuildContext context, {
        required ModelOrderListData orderDetails,
      }) {
    final statusColor = _statusColor(orderDetails.orderStatus.toString());

    return InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailsScreen(orderDetails: orderDetails),
            ),
          );

          /// 🔥 REFRESH AFTER POP
          if (result == true) {
            _cubit.getOrderSList();
          }
        },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderDetails.restaurantName.toString(),
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    orderDetails.orderStatus.toString(),
                    style: GoogleFonts.poppins(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              orderDetails.orderNumber ?? "",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),
            Text(
              formatDate(orderDetails.createdAt ?? ""),
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),
            Text(
              "₹ ${orderDetails.totalAmount.toString()}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.deepOrangeAccent
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Accepted":
        return Colors.blue;
      case "Preparing":
        return Colors.deepPurple;
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }
}

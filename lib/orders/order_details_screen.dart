import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/app_utilities/app_theme.dart';
import '../helper/constant/apiUrls.dart';
import '../model/order/modelOrdersList.dart';
import '../model/order/modelStatusChange.dart';
import '../network_configs/updatedNetworkRequest.dart';

class OrderDetailsScreen extends StatefulWidget {
  final ModelOrderListData orderDetails;

  const OrderDetailsScreen({super.key, required this.orderDetails});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    print("Get Status: ${widget.orderDetails.orderStatus}");
  }

  @override
  Widget build(BuildContext context) {

    final List items = widget.orderDetails.items ?? [];

    final double totalAmount = items.fold<double>(
      0.0,
          (sum, item) =>
      sum + ((item.quantity ?? 0) * (item.price ?? 0.0)),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.orderDetails.restaurantName ?? "Order Details"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// ITEMS LIST
            Expanded(
              child: _section(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ordered Items",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
        
                    if (items.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text("No items found"),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                          const Divider(height: 24),
                          itemBuilder: (_, index) {
                            final item = items[index];
        
                            return _orderItemTile(
                              name: item.variantName ?? "",
                              qty: item.quantity ?? 0,
                              price: item.price ?? 0.0,
                              note: "",
                            );
                          },
                        ),
                      ),
        
                    const Divider(height: 30),
        
                    _row(
                      "Total Amount",
                      "₹${totalAmount.toStringAsFixed(2)}",
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
        
            /// ACTION BUTTONS
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _handleReject,
                      child: const Text("Reject"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _handleAccept,
                      child: const Text("Accept"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Accept() async {
    int status = 0;
    if(widget.orderDetails.orderStatus == 0){
      status = 1;
    }else if(widget.orderDetails.orderStatus == 1){
      status = 2;
    }else if(widget.orderDetails.orderStatus == 2){
      status = 3;
    }
    setState(() => isLoading = true);

    final response = await UpdatedNetworkRequest().request(
      url: ApiUrls.orderStatus, // 🔴 Replace with your API
      method: "POST",
      body: {
        "orderId": widget.orderDetails.orderId,
        "orderStatus": status
      },
        tokenRequired: true
    );

    setState(() => isLoading = false);

    /// 🔥 PARSE MODEL HERE
    ModelChangeStatus loginModel = ModelChangeStatus.fromJson(response);

    if (loginModel.status == true) {
      Navigator.pop(context, true);
    } else {
      // ❌ ERROR
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["msg"] ?? "Login failed")),
      );
    }
  }

  // ---------------- ACTION HANDLERS ----------------

  void _handleAccept() async {
    setState(() => isLoading = true);

    // TODO: Call API here

    await Accept();
    await Future.delayed(const Duration(seconds: 1));

    setState(() => isLoading = false);
  }

  void _handleReject() async {
    setState(() => isLoading = true);

    // TODO: Call API here

    await Future.delayed(const Duration(seconds: 1));

    setState(() => isLoading = false);
  }

  // ---------------- UI HELPERS ----------------

  Widget _section({required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: child,
    );
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderItemTile({
    required String name,
    required int qty,
    required double price,
    required String note,
  }) {
    final double itemTotal = price * qty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              "x$qty",
              style: GoogleFonts.poppins(fontSize: 13),
            ),
            const SizedBox(width: 10),
            Text(
              "₹${itemTotal.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        if (note.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.info_outline,
                  size: 14, color: Colors.orange),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  note,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

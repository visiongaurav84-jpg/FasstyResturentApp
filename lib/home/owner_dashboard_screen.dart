import 'package:fassty_resturents_app/earning/earningsScreen.dart';
import 'package:fassty_resturents_app/menu/category/CategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/signUp/sign_up_screen.dart';
import '../helper/app_utilities/app_theme.dart';
import '../orders/orders_list_screen.dart';
import '../profile/profileScreen.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          "My Restaurant",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          Row(
            children: [
              Text(
                isOnline ? "Online" : "Offline",
                style: GoogleFonts.poppins(fontSize: 13),
              ),
              Switch(
                value: isOnline,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() => isOnline = value);
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// GREETING
            Text(
              "Good Afternoon 👋",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Welcome back, Kitchen King",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            /// SUMMARY CARDS (ROW)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrdersListScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: _summaryCard(
                      title: "Today's Orders",
                      value: "24",
                      icon: Icons.receipt_long,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _summaryCard(
                    title: "Revenue",
                    value: "₹8,450",
                    icon: Icons.currency_rupee,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// FULL WIDTH CARD
            _summaryCard(
              title: "Pending Orders",
              value: "3",
              icon: Icons.timelapse,
              color: Colors.orange,
            ),

            const SizedBox(height: 30),

            /// QUICK ACTIONS
            Text(
              "Quick Actions",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _actionTile(
                  icon: Icons.shopping_bag,
                  label: "Orders",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrdersListScreen(),
                      ),
                    );
                  },
                ),
                _actionTile(
                  icon: Icons.restaurant_menu,
                  label: "Menu",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoryScreen(),
                      ),
                    );
                  },
                ),
                _actionTile(
                  icon: Icons.account_circle,
                  label: "Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
                _actionTile(
                  icon: Icons.bar_chart,
                  label: "Earnings",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EarningsScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= UI WIDGETS =================

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 13),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: primaryColor),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helper/app_utilities/app_images.dart';
import '../helper/app_utilities/app_theme.dart';
import '../helper/dxWidget/drawer.dart';
import '../helper/dxWidget/dx_text.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // ✅ FIXED

  final List<Widget> _screens = [
    // DashboardScreen(),
    // DashboardScreen(),
    // DashboardScreen(),
    // DashboardScreen(),
    // DashboardScreen(),
  ];

  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   leadingWidth: 40, // reduce width if needed
      //   leading: Builder(
      //     builder: (context) => IconButton(
      //       onPressed: () {
      //         _scaffoldKey.currentState!.openDrawer();
      //       },
      //       icon: Image.asset(
      //         AppImages.menuImage,
      //         color: Colors.white,
      //         width: 30, // 👈 controls icon size
      //         height: 30,
      //       ),
      //       iconSize: 30, // 👈 important! ensures AppBar respects your size
      //       padding: const EdgeInsets.all(8), // spacing inside button
      //     ),
      //   ),
      //   title: const Text(
      //     "Welcome",
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),



      body: _screens[currentIndex],

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {
              currentIndex = 2;
            });
          },
          child: ClipOval(
            child: Image.asset(
              AppImages.appLogo,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Container(

        child: BottomAppBar(
          color: primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(Icons.verified_user, "user", 0),
                _buildNavItem(Icons.shopping_cart, "Cart", 1),
                const SizedBox(width: 20),
                _buildNavItem(Icons.favorite_border, "Favourites", 3),
                _buildNavItem(Icons.on_device_training_rounded, "Orders", 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ?  Colors.black : Colors.white,
          ),
          DxText(
            label,
            textColor: isSelected ? Colors.black  : Colors.white, mBold: true,
          ),
        ],
      ),
    );
  }
}

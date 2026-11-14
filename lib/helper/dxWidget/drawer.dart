
import 'package:flutter/material.dart';
import '../app_utilities/app_images.dart';
import '../app_utilities/app_theme.dart';
import '../app_utilities/method_utils.dart';
import '../custom_widgets/dailog/Logout.dart';
import '../localStorage/preference_handler.dart';
import '../routeAndBlocManager/navigator.dart';
import 'dx_text.dart';

class CustomDrawer extends StatefulWidget {


  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String profileImage = "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?semt=ais_hybrid&w=740&q=80";
  String? userName;
  String? userEmail;


  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    String?  name = await PreferenceHandler.getName();
    String?  email = await PreferenceHandler.getEmail();

    setState(() {
      userName = name;
      userEmail = email;

    });
    print("userName  $userName");

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: materialAccentColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2r8KL4BzmUQCXZWNipk4te1esSdtVyDWrvw&s")
                  )
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      profileImage,
                    ),
                    radius: 50,
                  )
,
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       DxTextWhite("Hello!"),
                      const SizedBox(width: 5),
                      DxTextWhite(
                        userName ??"",
                        mSize: 18,
                        mBold: true,
                      ),
                    ],
                  ),
                  DxTextWhite(userEmail ?? "", mSize:18,mBold: false),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: drawerList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    final data = drawerList[i];
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: data.icon,
                          title: DxText(
                            data.name,
                            mBold: true,
                          ),
                          // onTap: () => print("data.name"),
                          onTap: () => navigateTo(data.name),
                        ),
                        const Divider(
                          thickness: 0.2,
                          color: Colors.black,
                        )
                      ],
                    );
                  }),
            ),

          ],
        ),
      ),
    );
  }


  navigateTo(String name) {
    if (name == "Logout") {
      showLogoutDialog();
    }
    else if (name == "Delete Your Account") {
    //  showDeleteAcDialog();
    }

    else if (name == "Order History") {
    //  openScreenAsBottomToTop(Orderhistory());
    }
    else if (name == "Privacy Policy") {
     // openScreenAsBottomToTop(MyApp());
    }else{
      MethodUtils.toast( "Coming Soon");
    }
  }

  showLogoutDialog() =>
      showDialog(context: context, builder: (_) => LogoutDailog());



}

List<DrawerModel> drawerList = [
 // DrawerModel(icon:Image.asset(AppImages.profile, height: 27, width: 27, color: Colors.red,) ,name: "Profile"),
  DrawerModel(icon:Image.asset(AppImages.orderHistoryImage, height: 27, width: 27, color: primaryColor,) ,name: "History"),
  DrawerModel(icon:Image.asset(AppImages.privacyImage, height: 27, width: 27, color: primaryColor,) ,name: "Privacy Policy"),
  DrawerModel(icon:Image.asset(AppImages.deleteAC, height: 27, width: 27, color: primaryColor,) ,name: "Delete Your Account"),
  DrawerModel(icon:Image.asset(AppImages.logoutImage, height: 27, width: 27, color: primaryColor,) ,name: "Logout"),
];


class DrawerModel{
  Image icon;
  String name;
  DrawerModel({required this.icon, required this.name});
}
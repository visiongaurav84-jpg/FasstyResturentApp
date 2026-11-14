import 'package:flutter/material.dart';
import '../../helper/app_utilities/app_images.dart';
import '../../helper/app_utilities/size_reziser.dart';
import '../../helper/localStorage/preference_handler.dart';
import '../../helper/routeAndBlocManager/navigator.dart';
import 'onBordingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4), () =>  navigateInside());
  }

  navigateInside() async {

    openScreenAsPlatformWiseRoute(OnboardingScreen(), isExit: true);

    if (await PreferenceHandler.isLogIn()) {
      //openScreenAsPlatformWiseRoute(CategoryScreen(), isExit: true);
    } else {
      //openScreenAsPlatformWiseRoute(LoginScreen(), isExit: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
                child: Image.asset(
                  AppImages.appLogo,
                  width: SizeConfig.screenWidth*0.7,
                  height: SizeConfig.screenHeight*0.5,
                )),),
        )
    );
  }


}

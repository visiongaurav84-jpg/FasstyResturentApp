import 'package:flutter/material.dart';
import '../../helper/app_utilities/app_images.dart';
import '../../helper/routeAndBlocManager/navigator.dart';
import '../widget/welcomeScreen_widget.dart';
import 'login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': "Fresh Food, Fast Delivery",
      'subtitle': "Craving something delicious?Get your favorite meals delivered hot and fresh, right to your door.",
      'imageAsset': AppImages.d1,
    },
    {
      'title': "Healthy Choices, Happy You",
      'subtitle': "Discover nutritious meals made with love. Eat well, feel amazing, every single day.",
      'imageAsset': AppImages.b2,
    },
    {
      'title': "Exclusive Offers, Every Bite",
      'subtitle': "Enjoy mouthwatering discounts and daily deals. Because great food should always come with great savings!",
      'imageAsset': AppImages.b3,
    },
  ];


  void _onSkip() {
    _pageController.jumpToPage(onboardingData.length - 1);
  }

  void _onContinue() {
    openScreenAsPlatformWiseRoute(LoginScreen(), isExit: true);
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: PageView.builder(
          controller: _pageController,
          itemCount: onboardingData.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            final data = onboardingData[index];
            return WelcomeScreenWidget(
              title: data['title']!,
              subtitle: data['subtitle']!,
              imageAsset: data['imageAsset']!,
              onSkip: _onSkip,
              onContinue: _onContinue,
              currentPage: _currentPage,
              totalPages: onboardingData.length,
            );

          },
        ),
      ),
    );
  }
}
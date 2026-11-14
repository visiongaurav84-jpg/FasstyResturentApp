import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/splash_screen.dart';
import 'helper/app_utilities/app_theme.dart';
import 'helper/app_utilities/size_reziser.dart';
import 'helper/routeAndBlocManager/blocProvider.dart';

void main() {
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: BlocManager.blocProviders,
      child: MaterialApp(
          title: '',
          navigatorKey: navigatorKey,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: defaultAppThemeData,
          home: SplashScreen()
      ),
    );
  }
}
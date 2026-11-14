// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData get defaultAppThemeData => ThemeData(
    fontFamily: AppFonts.textRegular,
    primarySwatch: materialPrimaryColor,
    useMaterial3: false,
    // accentColor: materialAccentColor,
    // scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    appBarTheme: const AppBarTheme().copyWith(systemOverlayStyle:
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light)),
    platform: TargetPlatform.android,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black));

const MaterialColor materialPrimaryColor =  MaterialColor(
  0xFF444444,
   <int, Color>{
    50:  Color(0xFF444444),
    100:  Color(0xFF444444),
    200:  Color(0xFF444444),
    300:  Color(0xFF444444),
    400:  Color(0xFF444444),
    500:  Color(0xFF444444),
    600:  Color(0xFF444444),
    700:  Color(0xFF444444),
    800:  Color(0xFF444444),
    900:  Color(0xFF444444),
  },
);

/*
* New colors added to make ui more clean
* */

const textColorPrimary = Color(0xFF444444);
const cboGrey = Color(0xFF444444);
const widgetViewColor = Color(0xFF444444);
const layout_background = Color(0xFFF6F7FA);
const dbShadowColor = Color(0x95E9EBF0);
const backgroundColor = Color(0xAEFFFFFF);
const materialAccentColor1 =  Color(0xff033f6c);
const appbackgroundColor = Color(0xFF13C9E8);
const appDashbodbackgroundColor = Color(0x3086C0FF);
const projectFileColor = Color(0xFF515BBE);
Color get appIconTint_sky_blue => const Color(0xFF73d8d4);
Color get  appIconTint_mustard_yellow => const Color(0xFFffc980);
Color get  appIconTintDark_purple => const Color(0xFF8998ff);
Color get  appTxtTintDark_purple => const Color(0xFF515BBE);
const appIconTintDarkCherry = Color(0xFFf2866c);
Color get  appIconTintDark_sky_blue => const Color(0xFF73d8d4);
Color get  appDark_parrot_green => const Color(0xFF5BC136);
const appDarkRed = Color(0xFFF06263);
const appLightRed = Color(0xFFF89B9D);
const bluePurple = Color(0xFF3086C0);
const catOrange = Color(0xFFFF9781);
const greenBlue = Color(0xFF73D7D3);
const skyBlue = Color(0xFF87CEFA);

Color get primaryColor => Color(0xFFF452759);
Color get subPrimaryColor => Color(0xFF45395D);


Color get primaryRed => Colors.red;

Color get primaryRed20 => Colors.red.shade200;

Color get primaryRed40 => Colors.red.shade400;

Color get primaryRed60 => Colors.red.shade600;

// Color get materialAccentColor => Color(0xffFDC800);
Color get materialAccentColor => const Color(0xff033f6c);
//from old app
// Color get materialAccentColor => Color(0xff267b1b);

Color get textBlueDark => const Color(0xff3051A0);

Color get categoryIconCyan => const Color(0xff033f6c);

Color get categoryTitleGrayDark => const Color(0xff707070);

Color get categoryCardBg => const Color(0xFF444444);

Color get lightDividerColor => Colors.grey;

Color get borderSideColor => Colors.black26;

Color get borderSideFocusedColor => primaryColor;

Color get lightGrey50 => Colors.grey;

Color get whiteColor => Colors.white;

MaterialColor get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];

abstract class AppFonts {
  static String  textRegular = 'calibriRegular';
  static String  textBold = 'calibriBold';
  static String  textSemiBold = 'calibriLight';
}

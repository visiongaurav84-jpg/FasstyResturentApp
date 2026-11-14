import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class AppImages {
  static String imageExt(String path) => "assets/images/$path";

  static String get d1 => imageExt("doctor1.png");
  static String get b2 => imageExt("doctor1.png");
  static String get b3 => imageExt("doctor1.png");

  static String get noimage => imageExt("noImage.png");
  static String get appLogo => imageExt("appLogo.png");
  static String get login => imageExt("background.png");
  static String get back => imageExt("arrow.png");
  static String get loginBackground => imageExt("background.jpg");
  static String get backgroundLogin => imageExt("loginbackground.jpg");
  static String get plate => imageExt("plate.jpg");
  static String get otpBackground => imageExt("otpScreen.jpg");
  static String get cake => imageExt("cake.jpg");
  static String get menuImage => imageExt("menus.png");
  static String get cartImage => imageExt("addCart.png");
  static String get addImage => imageExt("add.png");
  static String get tickImage => imageExt("tick.png");
  static String get untickImage => imageExt("untick.png");
  static String get deleteAC => imageExt("deleteAC.png");

  static String get orderHistoryImage => imageExt("orderHistory.png");
  static String get privacyImage => imageExt("privacy.png");
  static String get logoutImage => imageExt("logout.png");

  static String get addLocationImage => imageExt("addLocation.png");
  static String get minusImage => imageExt("minus.png");
  static String get dropImage => imageExt("drop.png");
  static String get editingImage => imageExt("editing.png");
  static String get forgorPassword => imageExt("forgotPassword.png");
  static String get otp => imageExt("otp.png");

  static String get acceptOrder => imageExt("accept.png");
  static String get rejectOrder => imageExt("reject.png");
  static String get profile => imageExt("profile.png");

  static String get chnagePassword => imageExt("chnagePassword.png");
  static String get accessDeniedServer => imageExt("server.jpg");

  static String get splash => imageExt("splash.png");
  static String get pizza => imageExt("pizza.png");
  static String get buggerImage => imageExt("burgger.png");
  static String get utpammImage => imageExt("utppam.png");

  static String get southImage => imageExt("south.jpg");
  static String get chinesImage => imageExt("chines.jpeg");
  static String get snakes => imageExt("snakes.png");
  static String get momos => imageExt("momos.png");
  static String get rice => imageExt("rice.jpg");
  static String get pneer => imageExt("pneer.png");
  static String get roti => imageExt("roti.png");


  static String get res1 => imageExt("res1.jpeg");
  static String get res2 => imageExt("res2.jpg");
  static String get res3 => imageExt("res3.jpeg");
  static String get res4 => imageExt("res4.jpg");
  static String get res5 => imageExt("res5.jpeg");
  static String get res6 => imageExt("res6.jpeg");
  static String get res7 => imageExt("res7.jpeg");


  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

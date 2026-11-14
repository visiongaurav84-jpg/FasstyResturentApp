import 'package:flutter/foundation.dart';

class AppInfo {
  static const String companyName = "CBTECH";
  static const String companyAddress =
      "810 & 910, B Wing, Samartha Aishwarya, Off New Link Road, Opp Highland Park Coop Society, Andheri (W), Mumbai, Maharastra 400053\nPh- 022 26300106";
  static const String appName = "EHS25 HR INDIA PVT LTD";
  static const String appVersion = "1.0.0";
  static const String appVersionDisplay = "20200908";
  // static const String allRightReserved =
  //     "© 2020 \n CBO Infotech Private Limited \nAll Rights Reserved.";

  static const String _ANDROID = "ANDROID";
  static const String _IOS = "IOS";

  static const String MISByDailyTime = "41";
  static const String EditTime = "42";
  static const String EnterTime = "65";
  static const String ChangeOrder = "60";
  static const String UsageCharge = "40";
  static const String Client_Art = "31";
  static const String Client_Photo = "37";

  //Admin   (Have both rights awo/swo)
  static const String USER_ROLE_DC = "1";
  static const String USER_ROLE_PM = "2";
  static const String USER_ROLE_SUPER_ADMIN = "3";

  //Technicians (swo)
  static const String USER_ROLE_TECH = "9";
  static const String USER_ROLE_SPC = "12";

  // Artists
  static const String USER_ROLE_ARTIST = "6";
  static const String USER_ROLE_APC = "5";

  static String getPlatform() =>
      defaultTargetPlatform == TargetPlatform.android ? _ANDROID : _IOS;
}

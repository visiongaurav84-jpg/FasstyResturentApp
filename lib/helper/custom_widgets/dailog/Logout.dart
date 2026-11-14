import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../main.dart';
import '../../app_utilities/app_theme.dart';
import '../../app_utilities/device_info.dart';
import '../../app_utilities/method_utils.dart';
import '../../dxWidget/dx_text.dart';
import '../../localStorage/preference_handler.dart';

class LogoutDailog extends StatefulWidget {
  _LogoutDailogState createState() => _LogoutDailogState();
}




class _LogoutDailogState extends State<LogoutDailog> {




  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 150,
        width: 250,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: DxTextBlack(
                "Logout Confirmation?",
                mBold: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: DxTextBlack(
                "Are you sure want to Logout?",
                mBold: true,
                mSize: 14,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      PreferenceHandler.logout(context);
                    },

                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red, // Background color

                        borderRadius: BorderRadius.circular(5), // Optional: Round corners
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      height: 35,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                      // Background color
                        border: Border.all(
                          width: 0.6,
                          color: Colors.red // Border color
                        ),
                        borderRadius: BorderRadius.circular(5), // Optional: Round corners
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                      height: 35,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _deleteCacheDir() async {

    try{
      var appDir = (await getTemporaryDirectory()).path;
      new Directory(appDir).delete(recursive: true);

      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);}

      final appDir1 = await getApplicationSupportDirectory();
      if (appDir1.existsSync()) {
        appDir1.deleteSync(recursive: true);}
    }catch(e){
      print("clear pref $e");
    }
  }

}

//NEW Dialog
Future commonDialog(String msg,
    {Function()? positiveCallback,
    Function()? negativeCallback,
    bool isSuccess = true,
    String alertTitle = "Alert!!",
    String positiveBtnText = "OK",
    String negativeBtnText = "Cancel",
    String? dcrDate,
    String? dcrId,
    //for navigation case only.
    bool doNotPop = false,
    bool isFCMType = false,
    bool isRedBtnDialog = false}) async {
  final dcrDate = await PreferenceHandler.getEmployeeCode();
  final androidVersion = "";

  RichText richText({String? head, String? val}) => RichText(
          text: TextSpan(
              text: head,
              style: Theme.of(navigatorKey.currentContext!)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 10),
              children: <TextSpan>[
            TextSpan(
                text: val,
                style: Theme.of(navigatorKey.currentContext!)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ))
          ]));
  // bool isInTest = BlocProvider.of<SplashCubit>(context).getTestConfigs.testingStatus;
  return showDialog<bool>(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      print("Working");

      final isTablet = DeviceInfo.useMobileLayout(navigatorKey.currentContext!);
      // final isInLandscape = CBOResponsive.isLandScape(context);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 8, top: 35 + 8, right: 8, bottom: 4),
              margin: EdgeInsets.only(
                  top: 35,
                  right: isTablet ? (10) : 0,
                  left: isTablet ? (10) : 0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  DxTextBlack(
                    alertTitle,
                    mSize: 25,
                    mBold: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(8),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      thumbColor: Colors.grey.shade600,
                      radius: Radius.circular(8),
                      child: SingleChildScrollView(
                          child: DxText(
                        msg,
                        mBold: true,
                        mSize: 20,
                        maxLines: 10,
                            textAlign: TextAlign.center,

                      )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: negativeCallback != null
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.end,
                      children: [
                        if (negativeCallback != null)
                          Expanded(
                            child: ElevatedButton(
                              style: MethodUtils.raisedButtonStyle(Colors.red),
                              // color: Colors.grey.shade300,
                              child: DxTextWhite(negativeBtnText),
                              onPressed: () {
                                negativeCallback();
                              },
                            ),
                          ),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style:
                                  MethodUtils.raisedButtonStyle(Colors.green),
                              // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
                              child: isRedBtnDialog
                                  ? DxTextRed(
                                      positiveBtnText,
                                      mBold: true,
                                    )
                                  : DxTextWhite(
                                      positiveBtnText,
                                      mBold: true,
                                    ),
                              onPressed: () {
                                //for navigation case only, do not pop
                                if (!doNotPop) {
                                  Navigator.pop(
                                      navigatorKey.currentContext!, true);
                                }
                                if (positiveCallback != null) {
                                  positiveCallback();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 2,),


                ],
              ),
            ),

            Positioned(
              left: 8,
              right: 8,
              child: Container(
                // height: Constants.avatarRadius,
                // width: Constants.avatarRadius,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle,
                  //   boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.black38, offset: Offset(0, 10), blurRadius: 10),
                  // ]
                ),
                child: CircleAvatar(
                  backgroundColor: isSuccess ? Colors.green : primaryRed60,
                  radius: 35,
                  child: isSuccess
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 25,
                        ),
                ),
              ),
            ),
            // Positioned(
            //   top: 50,
            //   left: 10,
            //   child: Text("Version : ${AppConfigs().appVersion}", style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),),
            // ),
          ],
        ),
      );


    },
  );
}

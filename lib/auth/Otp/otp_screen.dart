import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../helper/app_utilities/app_images.dart';
import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/app_utilities/size_reziser.dart';
import '../../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../../helper/custom_widgets/app_circular_loader.dart';
import '../../../helper/dxWidget/dx_text.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../helper/routeAndBlocManager/navigator.dart';
import '../../../widget/bottomNavigator.dart';
import '../../helper/app_utilities/app_theme.dart';
import 'cubit/otp_cubit.dart';

class OtpScreen extends StatefulWidget {
   String email;
   String comeFrom;

   OtpScreen({required this.email, required this.comeFrom,});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? enterOTP;
  String? testStr;
  late OtpCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<OtpCubit>(context);
    phoneController.text = "nikhil@gmail.com";
    passwordController.text = "Nikhil@123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("first name: ${widget.email}}");
    return Scaffold(
      body: BlocConsumer<OtpCubit, OtpState>(
        builder: (BuildContext context, state) {
          if (state is OtpLoaded || state is OtpResendLoaded || state is OtpInitial || state is OtpError) {
            return body();
          } else if (state is OtpLoading) {
            return Stack(
              children: [
                body(),
                const AppLoaderProgress(),
              ],
            );
          }
          return AccessDeniedScreen(
            onPressed: () {
              _cubit.refresh();
            },
          );
        },
        listener: (BuildContext context, state) {
          if (state is OtpError) {
            if (state.error.isNotEmpty) {
              MethodUtils.toast(state.error);
            }
          } else if (state is OtpLoaded) {
              if(widget.comeFrom == "Login"){
                PreferenceHandler.setLogIn(true);
                openScreenAsLeftToRight(BottomNavigationBarScreen());
              }else{
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop();
              }
          }
        },
      ),
    );
  }

  Widget body(){
    return Stack(children: [
      Container(
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.otpBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.08),
        child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 120, left: 10, right: 10),
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      height: SizeConfig.screenHeight * 0.7 + 16,
                      width: SizeConfig.screenWidth * 0.92 - 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 5, right: 5),
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      height: SizeConfig.screenHeight * 0.7 + 8,
                      width: SizeConfig.screenWidth * 0.92 - 10,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    height: SizeConfig.screenHeight * 0.7,
                    width: SizeConfig.screenWidth * 0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(image: AssetImage(AppImages.otp),
                            height: SizeConfig.screenHeight * 0.20, fit: BoxFit.cover,),
                          SizedBox(height: 30,),
                          DxTextBlack(
                            "OTP Verification",
                            mSize: 28,
                            mBold: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DxTextBlack("Enter the OTP sent to ${widget.email}", maxLine: 2,),
                          const SizedBox(
                            height: 20,
                          ),
                          OTPTextField(
                            controller: otpController,
                            length: 6,
                            width: MediaQuery.of(context).size.width * 0.8,
                            textFieldAlignment: MainAxisAlignment.spaceEvenly,
                            fieldWidth: 35,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 5,
                            style: const TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              setState(() {
                                print(pin);
                                enterOTP = pin;
                              });
                            },
                            onCompleted: (pin) {
                              setState(() {
                                enterOTP = pin;
                                print(pin);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DxTextBlack("Didn't receive OTP?"),
                              TextButton(
                                onPressed: () {
                                  if(widget.comeFrom == "Login"){
                                    //_cubit.validLogin(widget.email, "", enterOTP ?? "");
                                  }else {
                                    _cubit.validSignUP(widget.email, "", enterOTP ?? "");
                                  }
                                },
                                child: const Text(
                                  "RESEND",
                                  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              height: 40,
                              margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                              width: SizeConfig.screenWidth,
                              child: ElevatedButton(
                                onPressed: () async {
                                  print("enter OTP ${enterOTP}");

                                    if(widget.comeFrom == "Login"){
                                      _cubit.validSignUP(widget.email, "", enterOTP ?? "");
                                    }else {
                                      _cubit.validSignUP(
                                          widget.email,
                                           "",
                                          enterOTP ?? "",
                                      );
                                    }
                                    },
                                child: Text("Verify OTP", style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                              )),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      )
    ]);
  }
}

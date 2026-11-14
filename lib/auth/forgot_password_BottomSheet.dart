import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../helper/app_utilities/app_images.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/app_utilities/size_reziser.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../helper/dxWidget/dx_input_fields.dart';
import '../../helper/dxWidget/dx_text.dart';
import '../helper/app_utilities/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  TextEditingController phoneController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool forgotPassword = true;
  bool otp = false;
  bool chnagePassword = false;
  String? enterOTP;
  String? currentOTP;

  Widget build(BuildContext context) {
    return body();
  }

  Widget body(){
    return SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: DxTextBlack(
                    'Forgot Password',
                    mBold: true,
                    mSize: 24,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Divider(),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child:
                        Image.asset(
                          AppImages.forgorPassword,
                          height: 250,
                        ),
                      ),
                      TextFieldWidget(
                        hintText: 'Enter your mobile or email',
                        prefixIcon: Icons.person,
                        textController: phoneController,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            //_cubit.mobileEmailValidation(phoneController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: DxTextWhite("Submit", mBold: true,),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                visible: forgotPassword,
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child:
                        Image.asset(
                          AppImages.otp,
                          height: 180,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: OTPTextField(
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
                              print(pin);
                              enterOTP = pin;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                          width: SizeConfig.screenWidth,
                          child: ElevatedButton(
                            onPressed: () {
                              print("back OTP ${currentOTP}");
                              print("enter OTP ${enterOTP}");
                              if(currentOTP == enterOTP) {
                                setState(() {
                                  forgotPassword = false;
                                  chnagePassword = true;
                                  otp = false;
                                });
                              }else{
                                MethodUtils.toast("Please enter the valid OTP");
                              }
                            },
                            child: Text("Submit", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          )),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                visible: otp,
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child:
                        Image.asset(
                          AppImages.chnagePassword,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 40),

                      TextFieldWidget(
                        hintText: 'Enter New Password',
                        prefixIcon: Icons.password,
                        textController: passwordController,
                      ),
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        hintText: 'Enter Confirm Password',
                        prefixIcon: Icons.password,
                        textController: confirmPasswordController,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                           // _cubit.forgotPassword(phoneController.text, passwordController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: DxTextWhite("Submit", mBold: true,),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                visible: chnagePassword,
              )
            ]
        ));
  }
}

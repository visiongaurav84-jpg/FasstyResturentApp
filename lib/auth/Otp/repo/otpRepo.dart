import 'package:flutter/cupertino.dart';
import '../../../../Model/reposeCallBack.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../model/modelAuth/modelSignUp.dart';

abstract class OtoRepoAbstract {
  Future<ApiResponse<ModelSignUpVerification>> validSignUp({required String email, required String phone, required String otp});
}

class OtpRepo implements OtoRepoAbstract {
  NetworkRequest networkRequest;
  OtpRepo({required this.networkRequest});
  @override

  Future<ApiResponse<ModelSignUpVerification>> validSignUp(
      {required String email, required String phone, required String otp}) async {

    Map<String, String> signUpMap = {
      "email": email,
      "number": phone,
      "otp":otp,
    };

    debugPrint("Valid SignUP Data Param is $signUpMap");
    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(ApiUrls.validEmailOrPhone, signUpMap);
    ModelSignUpVerification? _userModel;
    if (resp["status"] == true) {
      Map<String,dynamic> data = resp as Map<String,dynamic>;
      if(data !=null){
        _userModel = ModelSignUpVerification.fromJson(data);
      }
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _userModel,
      );
    } else {
      return ApiResponse(
        isSuccess: false,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }




}
import 'package:flutter/cupertino.dart';
import '../../../../Model/reposeCallBack.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../model/modelAuth/modelLogin.dart';
import '../../../model/modelAuth/modelSignUp.dart';

abstract class LoginRepoAbstract {
  Future<ApiResponse<ModelLogin>> validLogin({required String email, required String password,});
}

class LoginRepo implements LoginRepoAbstract {
  NetworkRequest networkRequest;
  LoginRepo({required this.networkRequest});
  @override

  Future<ApiResponse<ModelLogin>> validLogin(
      {required String email, required String password}) async {

    Map<String, String> loginMap = {
      "email": email,
      "password": password,
    };

    debugPrint("Valid SignUP Data Param is $loginMap");
    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(ApiUrls.login, loginMap);
    ModelLogin? _userModel;
    if (resp["status"] == true) {
      Map<String,dynamic> data = resp as Map<String,dynamic>;
      if(data !=null){
        _userModel = ModelLogin.fromJson(data);
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
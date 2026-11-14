import 'package:flutter/cupertino.dart';
import '../../../../Model/reposeCallBack.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../model/modelAuth/modelSignUp.dart';

abstract class SignupRepoAbstract {
  Future<ApiResponse<ModelSignUP>> validSignUp(SignupRequest request);
}

class SignupRepo implements SignupRepoAbstract {
  final NetworkRequest networkRequest;

  SignupRepo({required this.networkRequest});

  @override
  Future<ApiResponse<ModelSignUP>> validSignUp(SignupRequest request) async {

    final Map<String, dynamic> body = {
      "id": request.id,
      "restaurantName": request.restaurantName,
      "firstName": request.firstName,
      "lastName": request.lastName,
      "number": request.number,
      "email": request.email,
      "pan": request.pan,
      "aadhar": request.aadhar,
      "restaurantDes": request.restaurantDes,
      "logoUrl": request.logoUrl,
      "password": request.password,
      "isApproved": request.isApproved,
      "restaurantType": request.restaurantType,
      "openingTime": request.openingTime,
      "closingTime": request.closingTime,
      "address": request.address,
      "city": request.city,
      "state": request.state,
      "pincode": request.pincode,
      "latitude": request.latitude,
      "longitude": request.longitude,
      "averageRating": request.averageRating,
      "totalReviews": request.totalReviews,
      "isActive": request.isActive,
    };


    debugPrint("Valid SignUp Params: $body");

    try {
      final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.signUP,
        body,
      );

      final bool status = resp["status"] == true;
      final String message = resp["message"]?.toString() ?? "Unknown error";

      if (status) {
        final model = ModelSignUP.fromJson(resp);
        return ApiResponse(
          isSuccess: true,
          errorCause: message,
          resObject: model,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          errorCause: message,
          resObject: null,
        );
      }
    } catch (e) {
      debugPrint("Signup Repo Error: $e");
      return ApiResponse(
        isSuccess: false,
        errorCause: "Something went wrong",
        resObject: null,
      );
    }
  }

}

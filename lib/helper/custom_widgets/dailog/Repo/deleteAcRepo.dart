import 'package:flutter/cupertino.dart';
import '../../../../Model/reposeCallBack.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../constant/apiUrls.dart';
import '../../../localStorage/preference_handler.dart';



abstract class deleteAcRepoAbstract {
  Future<ApiResponse<String>> deleteAC();


}

class deleteAcRepo implements deleteAcRepoAbstract {
  NetworkRequest networkRequest;
  deleteAcRepo({required this.networkRequest});




  @override
  Future<ApiResponse<String>> deleteAC() async {
    String? userId = await PreferenceHandler.getUserId();

    Map<String, dynamic> resp = await networkRequest.networkCallDelete(
      ApiUrls.deleteAc(userId!), parameter: {}, );


    if (resp["status"] == true) {
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: resp["message"],
      );
    } else {
      return ApiResponse(
        isSuccess: false,
        errorCause: resp["message"],
        resObject: resp["message"],);
    }
  }




}

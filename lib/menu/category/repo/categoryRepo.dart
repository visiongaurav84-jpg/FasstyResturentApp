import 'package:flutter/cupertino.dart';
import '../../../../Model/reposeCallBack.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../model/category/modelAddCategory.dart';
import '../../../model/category/modelCategory.dart';
import '../../../model/modelAuth/modelLogin.dart';
import '../../../model/modelAuth/modelSignUp.dart';

abstract class CategoryRepoAbstract {
  Future<ApiResponse<ModelCategoryList>> categoryList(String comeFrom);
}

class CategoryRepo implements CategoryRepoAbstract {
  NetworkRequest networkRequest;
  CategoryRepo({required this.networkRequest});
  @override

  Future<ApiResponse<ModelCategoryList>> categoryList(String comeFrom) async {
    String? userId = await PreferenceHandler.getUserId();
    var urlStr = comeFrom == "Add" ? ApiUrls.categoryList : ApiUrls.categoryListByRestaurant+userId.toString();

    Map<String, dynamic> resp = await networkRequest.networkCallGetMap(urlStr, accessToken: true);
    ModelCategoryList? _userModel;

    if (resp["status"] == true) {
      Map<String,dynamic> data = resp as Map<String,dynamic>;
      if(data !=null){
        _userModel = ModelCategoryList.fromJson(data);
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

  Future<ApiResponse<ModelAddCategory>> addSelectedCategories({
    required List<int> categoryIds,
  }) async {

    /// API body
    String? userId = await PreferenceHandler.getUserId();
    Map<String, dynamic> body = {
      "restaurantId" : userId.toString(),
      "categoryIds": categoryIds, // [1,2,3]
    };

    debugPrint("Add Category Params: $body");


    var urlStr = ApiUrls.addCategories;


    Map<String, dynamic> resp =
    await networkRequest.networkCallPostMap2(
      urlStr,
      body,
      tokenAccess: true
    );

    ModelAddCategory? categoryModel;

    if (resp["status"] == true) {
      Map<String, dynamic> data = resp as Map<String, dynamic>;

      if (data != null) {
        categoryModel = ModelAddCategory.fromJson(data);
      }

      return ApiResponse<ModelAddCategory>(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: categoryModel,
      );
    } else {
      return ApiResponse<ModelAddCategory>(
        isSuccess: false,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }





}
import 'package:fassty_resturents_app/model/category/modelAddCategory.dart';
import 'package:fassty_resturents_app/model/category/modelCategory.dart';
import 'package:flutter/cupertino.dart';
import '../../../../Model/reposeCallBack.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../model/item/modelAddItems.dart';
import '../../../model/item/modelIteamList.dart';
import '../AddEditItemScreen.dart';


abstract class ItemRepoAbstract {
  Future<ApiResponse<ModelItemList>> itemList(String comeFrom);
}

class ItemRepo implements ItemRepoAbstract {
  NetworkRequest networkRequest;

  ItemRepo({required this.networkRequest});

  @override
  Future<ApiResponse<ModelItemList>> itemList(String categoryId) async {
    String? userId = await PreferenceHandler.getUserId();

    var urlStr = ApiUrls.itemList+(userId ?? "")+"/"+categoryId;
    //var urlStr = ApiUrls.itemList+"1"+"/"+"1";

    Map<String, dynamic> resp =
    await networkRequest.networkCallGetMap(
      urlStr,
      accessToken: true,
    );

    ModelItemList? itemModel;

    if (resp["status"] == true) {
      Map<String, dynamic> data = resp as Map<String, dynamic>;

      if (data != null) {
        itemModel = ModelItemList.fromJson(data);
      }

      return ApiResponse<ModelItemList>(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: itemModel,
      );
    } else {
      return ApiResponse<ModelItemList>(
        isSuccess: false,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }

  /// Add Items....
  Future<ApiResponse<ModelAddItems>> addMenuItem({required DataItemList item,}) async {
    /// API body → root-level MenuItem JSON
    final Map<String, dynamic> body = item.toJson();

    debugPrint("Add Item Params: $body");

    final bool isAdd = item.id == 0;

    final resp = isAdd
        ? await networkRequest.networkCallPostMap2(
      ApiUrls.addItem,
      body,
      tokenAccess: true,
    )
        : await networkRequest.networkCallPutMap(
      ApiUrls.addItem,
      body,
      accessToken: true,
    );

    if (resp["status"] == true) {
      return ApiResponse<ModelAddItems>(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: ModelAddItems.fromJson(resp),
      );
    }

    return ApiResponse<ModelAddItems>(
      isSuccess: false,
      errorCause: resp["message"],
      resObject: null,
    );

  }

  /// Delete Items....
  Future<ApiResponse<ModelAddItems>> deleteMenuItem({required String itemId}) async {
    final resp = await networkRequest.networkCallDelete(
      ApiUrls.deleteAddress(itemId), parameter: {}, accessToken: true);

    if (resp["status"] == true) {
      return ApiResponse<ModelAddItems>(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: ModelAddItems.fromJson(resp),
      );
    }

    return ApiResponse<ModelAddItems>(
      isSuccess: false,
      errorCause: resp["message"],
      resObject: null,
    );

  }

  @override
  Future<ApiResponse<Map<String, dynamic>>>uploadImage(String image, String folderName) async {
    Map<String, dynamic> resp = await networkRequest.uploadFile(ApiUrls.uploadProfileImage, image, folderName);
    if (resp["status"] == true) {
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: resp["data"],
      );
    } else {
      return ApiResponse(
        isSuccess: false,
        errorCause: resp["message"],
        resObject: resp["data"],
      );
    }
  }





}

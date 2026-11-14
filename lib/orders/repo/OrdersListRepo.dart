import '../../../../Model/reposeCallBack.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../model/order/modelOrdersList.dart';

/// =======================
/// HTTP METHODS
/// =======================
enum HttpMethod { get, post, delete, put }

/// =======================
/// ABSTRACT REPOSITORY
/// =======================
abstract class OrdersListRepoAbstract {
  Future<ApiResponse<ModelOrderList>> getAllOrdersAPI();
}

/// =======================
/// IMPLEMENTATION
/// =======================
class OrdersListRepo implements OrdersListRepoAbstract {
  final NetworkRequest networkRequest;

  OrdersListRepo({required this.networkRequest});

  /// =======================
  /// COMMON API HANDLER
  /// =======================
  Future<ApiResponse<T>> _handleApi<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? body,
  }) async {
    late Map<String, dynamic> response;

    switch (method) {
      case HttpMethod.get:
        response = await networkRequest.networkCallGetMap(
          url,
          accessToken: true,
        );
        break;

      case HttpMethod.post:
        response = await networkRequest.networkCallPostMap2(
          url,
          body ?? {},
          tokenAccess: true,
        );
        break;

      case HttpMethod.put:
        response = await networkRequest.networkCallPutMap(
          url,
          body ?? {},
          accessToken: true,
        );
        break;

      case HttpMethod.delete:
        response = await networkRequest.networkCallDelete(
          url,
          accessToken: true,
          parameter: const {},
        );
        break;
    }

    return ApiResponse(
      isSuccess: response["status"] == true,
      errorCause: response["message"] ?? "Something went wrong",
      resObject: fromJson(response),
    );
  }

  /// =======================
  /// GET ALL Orders
  /// =======================
  @override
  Future<ApiResponse<ModelOrderList>> getAllOrdersAPI() async {
    final String? userId = await PreferenceHandler.getUserId();
    return _handleApi(
      url: ApiUrls.orderList + (userId ?? ""),
      method: HttpMethod.get,
      fromJson: ModelOrderList.fromJson,
    );
  }

}

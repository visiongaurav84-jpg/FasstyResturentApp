
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiUrls {
  static String baseUrl(String endPoint) =>
      "https://fasttyapi.runasp.net/api/$endPoint";


////==================== Live Base Url =========================///////////

  static String signUP = baseUrl("restaurants/");
  static String validEmailOrPhone = baseUrl("restaurants/verify-restaurant-otp");
  static String login = baseUrl("admin/auth/login");
  static String categoryList = baseUrl("categories/active-categories");
  static String categoryListByRestaurant = baseUrl("categories/active-categories-by-restaurant/");
  static String addCategories = baseUrl("restaurants/assign-categories-to-restaurant");
  static String orderList = baseUrl("orders/user/");
  static String orderStatus = baseUrl("orders/changeOrderStatus");

  static String itemList = baseUrl("food-items/category/");
  static String addItem = baseUrl("food-items/");
  static String uploadProfileImage = baseUrl("FileUpload/Upload");

  static String forgotEmail = baseUrl("Login/ForgotPassword");
  static String getCategory = baseUrl("Category/Get");
  static String getOffers = baseUrl("Offers/Get");
  static String forgotPassword = baseUrl("Login/ResetPassword");


  static String getResturents = baseUrl("Restaurant/GetRestaurentByCategory");
  static String getItems = baseUrl("Food/GetFoodByRestaurentCategoryId");
  static String getItemsQuantityType = baseUrl("ItemQuantity/GetByFoodId/");
  static String addItemsInCart = baseUrl("AddToCart/Create/");
  static String getAddToCartItems = baseUrl("AddToCart/GetFoodInAddToCart/");
  static String getAllResturents = baseUrl("Restaurant/Get");


  //==================Profile==============//

  static String getProfileDetails(String id) => baseUrl("Login/ViewProfile/$id");
  static String editProfileDetails = baseUrl("Login/EditProfile");




  ////====================Add Address=====================////
static String addAddress = baseUrl("Address/Create");
static String editAddress = baseUrl("Address/Edit");
static String deleteAc(String userId) => baseUrl("Login/Delete/$userId");

static String deleteAddress(String id) => baseUrl("Address/Delete/$id");
static String viewAddress(String id) => baseUrl("Address/GetFoodInAddress/$id");
static String deleteItemsInCart(String id) => baseUrl("AddToCart/Delete/$id");
static String deleteItemsInCartByUserId(String id) => baseUrl("AddToCart/DeleteByUser/$id");
static String updateItemsInCart = baseUrl("AddToCart/Edit");
static String placeOrder = baseUrl("OrderDetails/Create");
static String getOrderHistory = baseUrl("OrderDetails/GetFoodInOrderDetails/");
static String rejectedItemsInOrderHistory = baseUrl("OrderDetails/UpdateIsCancel");
static String acceptedItemsInOrderHistory = baseUrl("OrderDetails/UpdateIsDelevered");
static String getResturentsOffers = baseUrl("Offers/GetOffers");


}

class AppAuth {
  AppAuth._();

  static String get appTraceReceiverEmail => "gawasthi@planetecomsolutions.com";
  static String get appMailerEmail => "pecsjatin@gmail.com";
  static String get appMailerPassword => "jatinflutter";

}

class AppInfo {
  static const String companyName = "PECS";
  static const String companyAddress =
      "Delhi";
  static const String appName = "Exhibit Power";
  static const String appVersion = "1.0.0";
  static const String appVersionDisplay = "20211005 ";
  static const String allRightReserved =
      "Delhi";

  static const String _ANDROID = "ANDROID";
  static const String _IOS = "IOS";

  static String getPlatform() =>
      defaultTargetPlatform == TargetPlatform.android ? _ANDROID : _IOS;
}

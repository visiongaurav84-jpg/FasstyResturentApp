import 'modelIteamList.dart';

class ModelAddItems {
  DataAddItems? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelAddItems(
      {this.data, this.statusCode, this.title, this.message, this.status});

  ModelAddItems.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataAddItems.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class DataAddItems {
  int? id;
  int? restaurantId;
  int? categoryId;
  String? name;
  String? description;
  double? price;
  double? discountedPrice;
  String? imageUrl;
  int? foodType;
  bool? isAvailable;
  bool? isActive;
  List<Variants>? variants;

  DataAddItems(
      {this.id,
        this.restaurantId,
        this.categoryId,
        this.name,
        this.description,
        this.price,
        this.discountedPrice,
        this.imageUrl,
        this.foodType,
        this.isAvailable,
        this.isActive,
        this.variants});

  DataAddItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurantId'];
    categoryId = json['categoryId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    discountedPrice = json['discountedPrice'];
    imageUrl = json['imageUrl'];
    foodType = json['foodType'];
    isAvailable = json['isAvailable'];
    isActive = json['isActive'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurantId'] = this.restaurantId;
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountedPrice'] = this.discountedPrice;
    data['imageUrl'] = this.imageUrl;
    data['foodType'] = this.foodType;
    data['isAvailable'] = this.isAvailable;
    data['isActive'] = this.isActive;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


import 'dart:ffi';

class ModelItemList {
  List<DataItemList>? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelItemList(
      {this.data, this.statusCode, this.title, this.message, this.status});

  ModelItemList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataItemList>[];
      json['data'].forEach((v) {
        data!.add(new DataItemList.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class DataItemList {
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

  DataItemList(
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

  DataItemList.fromJson(Map<String, dynamic> json) {
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

class Variants {
  int? id;
  String? variantName;
  String? description;
  String? imageUrl;
  double? price;
  bool? isDefault;

  Variants({this.id, this.variantName, this.description, this.imageUrl, this.price, this.isDefault});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variantName = json['variantName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variantName'] = this.variantName;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

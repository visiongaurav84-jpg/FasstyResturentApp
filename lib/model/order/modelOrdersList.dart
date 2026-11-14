class ModelOrderList {
  final List<ModelOrderListData>? data;
  final int? statusCode;
  final String? title;
  final String? message;
  final bool? status;

  ModelOrderList({
    this.data,
    this.statusCode,
    this.title,
    this.message,
    this.status,
  });

  factory ModelOrderList.fromJson(Map<String, dynamic> json) {
    return ModelOrderList(
      data: json['data'] != null
          ? List<ModelOrderListData>.from(
          json['data'].map((x) => ModelOrderListData.fromJson(x)))
          : null,
      statusCode: json['statusCode'],
      title: json['title'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((x) => x.toJson()).toList(),
    'statusCode': statusCode,
    'title': title,
    'message': message,
    'status': status,
  };
}

class ModelOrderListData {
  final int? orderId;
  final String? orderNumber;
  final double? totalAmount;
  final int? orderStatus;
  final int? paymentStatus;
  final String? createdAt;
  final String? restaurantName;
  final Address? address;
  final List<Items>? items;

  ModelOrderListData({
    this.orderId,
    this.orderNumber,
    this.totalAmount,
    this.orderStatus,
    this.paymentStatus,
    this.createdAt,
    this.restaurantName,
    this.address,
    this.items,
  });

  factory ModelOrderListData.fromJson(Map<String, dynamic> json) {
    return ModelOrderListData(
      orderId: json['orderId'],
      orderNumber: json['orderNumber'],
      totalAmount: json['totalAmount'] != null
          ? (json['totalAmount'] as num).toDouble()
          : null,
      orderStatus: json['orderStatus'],
      paymentStatus: json['paymentStatus'],
      createdAt: json['createdAt'],
      restaurantName: json['restaurantName'],
      address:
      json['address'] != null ? Address.fromJson(json['address']) : null,
      items: json['items'] != null
          ? List<Items>.from(
          json['items'].map((x) => Items.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'orderNumber': orderNumber,
    'totalAmount': totalAmount,
    'orderStatus': orderStatus,
    'paymentStatus': paymentStatus,
    'createdAt': createdAt,
    'restaurantName': restaurantName,
    'address': address?.toJson(),
    'items': items?.map((x) => x.toJson()).toList(),
  };
}

class Address {
  final int? id;
  final String? type;
  final String? houseNo;
  final String? addressLine;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final bool? isDefault;
  final String? userId;

  Address({
    this.id,
    this.type,
    this.houseNo,
    this.addressLine,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.userId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      type: json['type'],
      houseNo: json['houseNo'],
      addressLine: json['addressLine'],
      postalCode: json['postalCode'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      isDefault: json['isDefault'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'houseNo': houseNo,
    'addressLine': addressLine,
    'postalCode': postalCode,
    'latitude': latitude,
    'longitude': longitude,
    'isDefault': isDefault,
    'userId': userId,
  };
}

class Items {
  final int? foodItemId;
  final int? foodVariantId;
  final String? foodName;
  final String? variantName;
  final int? quantity;
  final double? price;
  final String? description;
  final String? imageUrl;

  Items({
    this.foodItemId,
    this.foodVariantId,
    this.foodName,
    this.variantName,
    this.quantity,
    this.price,
    this.description,
    this.imageUrl,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      foodItemId: json['foodItemId'],
      foodVariantId: json['foodVariantId'],
      foodName: json['foodName'],
      variantName: json['variantName'],
      quantity: json['quantity'],
      price: json['price'] != null
          ? (json['price'] as num).toDouble()
          : null,
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'foodItemId': foodItemId,
    'foodVariantId': foodVariantId,
    'foodName': foodName,
    'variantName': variantName,
    'quantity': quantity,
    'price': price,
    'description': description,
    'imageUrl': imageUrl,
  };
}

class ModelLogin {
  DataLogin? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelLogin({
    this.data,
    this.statusCode,
    this.title,
    this.message,
    this.status,
  });

  ModelLogin.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataLogin.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (data != null) {
      json['data'] = data!.toJson();
    }
    json['statusCode'] = statusCode;
    json['title'] = title;
    json['message'] = message;
    json['status'] = status;
    return json;
  }
}

class DataLogin {
  int? adminId;
  String? fullName;
  String? email;
  String? role;
  String? token;
  List<Restaurants>? restaurants;

  DataLogin({
    this.adminId,
    this.fullName,
    this.email,
    this.role,
    this.token,
    this.restaurants,
  });

  DataLogin.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    token = json['token'];
    if (json['restaurants'] != null) {
      restaurants = (json['restaurants'] as List)
          .map((e) => Restaurants.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['adminId'] = adminId;
    json['fullName'] = fullName;
    json['email'] = email;
    json['role'] = role;
    json['token'] = token;
    if (restaurants != null) {
      json['restaurants'] = restaurants!.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

class Restaurants {
  int? id;
  String? restaurantName;
  String? firstName;
  String? lastName;
  String? number;
  String? email;
  String? pan;
  String? aadhar;
  String? restaurantDes;
  String? logoUrl;
  int? userId;
  bool? isApproved;
  int? restaurantType;
  String? openingTime;
  String? closingTime;
  String? address;
  String? city;
  String? state;
  String? pincode;
  double? latitude;
  double? longitude;
  double? averageRating;
  int? totalReviews;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Restaurants({
    this.id,
    this.restaurantName,
    this.firstName,
    this.lastName,
    this.number,
    this.email,
    this.pan,
    this.aadhar,
    this.restaurantDes,
    this.logoUrl,
    this.userId,
    this.isApproved,
    this.restaurantType,
    this.openingTime,
    this.closingTime,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.latitude,
    this.longitude,
    this.averageRating,
    this.totalReviews,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurantName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    number = json['number'];
    email = json['email'];
    pan = json['pan'];
    aadhar = json['aadhar'];
    restaurantDes = json['restaurantDes'];
    logoUrl = json['logoUrl'];
    userId = json['userId'];
    isApproved = json['isApproved'];
    restaurantType = json['restaurantType'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
    averageRating = json['averageRating'];
    totalReviews = json['totalReviews'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['restaurantName'] = restaurantName;
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    json['number'] = number;
    json['email'] = email;
    json['pan'] = pan;
    json['aadhar'] = aadhar;
    json['restaurantDes'] = restaurantDes;
    json['logoUrl'] = logoUrl;
    json['userId'] = userId;
    json['isApproved'] = isApproved;
    json['restaurantType'] = restaurantType;
    json['openingTime'] = openingTime;
    json['closingTime'] = closingTime;
    json['address'] = address;
    json['city'] = city;
    json['state'] = state;
    json['pincode'] = pincode;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['averageRating'] = averageRating;
    json['totalReviews'] = totalReviews;
    json['isActive'] = isActive;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}

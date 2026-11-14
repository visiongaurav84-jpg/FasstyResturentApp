
class ModelSignUP {
  DataSignUp? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelSignUP(
      {this.data, this.statusCode, this.title, this.message, this.status});

  ModelSignUP.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataSignUp.fromJson(json['data']) : null;
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

class DataSignUp {
  int? id;
  String? restaurantName;
  String? firstName;
  String? lastName;
  String? number;
  String? email;
  String? pan;
  String? aadhar;
  String? profileImage;
  String? restaurantDes;
  String? password;
  int? restaurantType;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  DataSignUp(
      {this.id,
        this.restaurantName,
        this.firstName,
        this.lastName,
        this.number,
        this.email,
        this.pan,
        this.aadhar,
        this.profileImage,
        this.restaurantDes,
        this.password,
        this.restaurantType,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  DataSignUp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurantName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    number = json['number'];
    email = json['email'];
    pan = json['pan'];
    aadhar = json['aadhar'];
    profileImage = json['profileImage'];
    restaurantDes = json['restaurantDes'];
    password = json['password'];
    restaurantType = json['restaurantType'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurantName'] = this.restaurantName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['number'] = this.number;
    data['email'] = this.email;
    data['pan'] = this.pan;
    data['aadhar'] = this.aadhar;
    data['profileImage'] = this.profileImage;
    data['restaurantDes'] = this.restaurantDes;
    data['password'] = this.password;
    data['restaurantType'] = this.restaurantType;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}

class ModelSignUpVerification {
  String? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelSignUpVerification(
      {this.data, this.statusCode, this.title, this.message, this.status});

  ModelSignUpVerification.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['statusCode'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['statusCode'] = this.statusCode;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class SignupRequest {
  final int id;
  final String restaurantName;
  final String firstName;
  final String lastName;
  final String number;
  final String email;
  final String pan;
  final String aadhar;
  final String restaurantDes;
  final String logoUrl;
  final String password;
  final bool isApproved;
  final int restaurantType;
  final String openingTime;
  final String closingTime;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final double latitude;
  final double longitude;
  final double averageRating;
  final int totalReviews;
  final bool isActive;

  SignupRequest({
    required this.id,
    required this.restaurantName,
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.email,
    required this.pan,
    required this.aadhar,
    required this.restaurantDes,
    required this.logoUrl,
    required this.password,
    required this.isApproved,
    required this.restaurantType,
    required this.openingTime,
    required this.closingTime,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.latitude,
    required this.longitude,
    required this.averageRating,
    required this.totalReviews,
    required this.isActive,
  });
}







class ModelAddCategory {
  bool? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelAddCategory(
      {this.data, this.statusCode, this.title, this.message, this.status});

  ModelAddCategory.fromJson(Map<String, dynamic> json) {
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

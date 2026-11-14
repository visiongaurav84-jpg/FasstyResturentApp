class ModelCategoryList {
  List<DataCategory>? data;
  int? statusCode;
  String? title;
  String? message;
  bool? status;

  ModelCategoryList(
      {this.data, this.statusCode, this.title, this.message, this.status});

  ModelCategoryList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataCategory>[];
      json['data'].forEach((v) {
        data!.add(new DataCategory.fromJson(v));
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

class DataCategory {
  int? id;
  String? name;
  String? imageUrl;
  String? description;
  bool? isActive;
  bool? isSelected;

  DataCategory(
      {this.id,
        this.name,
        this.imageUrl,
        this.description,
        this.isActive,
        this.isSelected});

  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    isActive = json['isActive'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

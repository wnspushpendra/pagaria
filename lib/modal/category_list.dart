class CategoryListResponse {
  bool? status;
  String? message;
  List<Categories>? categoryList;

  CategoryListResponse({this.status, this.message, this.categoryList});

  CategoryListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      categoryList = <Categories>[];
      json['record'].forEach((v) {
        categoryList!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (categoryList != null) {
      data['record'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? catName;
  String? catImage;
  String? catImageUrl;
  String? catStatus;
  String? createdById;
  String? adminId;
  String? createdAt;
  String? updatedAt;
  CategoryCreatedBy? categoryCreatedBy;

  Categories(
      {this.id,
        this.catName,
        this.catImage,
        this.catImageUrl,
        this.catStatus,
        this.createdById,
        this.adminId,
        this.createdAt,
        this.updatedAt,
        this.categoryCreatedBy});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    catImage = json['cat_image'];
    catImageUrl = json['cat_image_url'];
    catStatus = json['cat_status'];
    createdById = json['created_by_id'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryCreatedBy = json['category_created_by'] != null
        ? CategoryCreatedBy.fromJson(json['category_created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_name'] = catName;
    data['cat_image'] = catImage;
    data['cat_image_url'] = catImageUrl;
    data['cat_status'] = catStatus;
    data['created_by_id'] = createdById;
    data['admin_id'] = adminId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (categoryCreatedBy != null) {
      data['category_created_by'] = categoryCreatedBy!.toJson();
    }
    return data;
  }
}

class CategoryCreatedBy {
  int? id;
  String? fullName;
  String? email;

  CategoryCreatedBy({this.id, this.fullName, this.email});

  CategoryCreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    return data;
  }
}

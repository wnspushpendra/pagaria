class ProductDetailResponse {
  bool? status;
  String? message;
  ProductDetails? productDetail;
  List<Productgallery>? productgallery;

  ProductDetailResponse(
      {this.status, this.message, this.productDetail, this.productgallery});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetail =
    json['record'] != null ? ProductDetails.fromJson(json['record']) : null;
    if (json['productgallery'] != null) {
      productgallery = <Productgallery>[];
      json['productgallery'].forEach((v) {
        productgallery!.add(Productgallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (productDetail != null) {
      data['record'] = productDetail!.toJson();
    }
    if (productgallery != null) {
      data['productgallery'] =
          productgallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  int? id;
  String? prodName;
  String? prodImage;
  String? prodImageUrl;
  String? prodShortDescription;
  String? prodDescription;
  String? prodDistributorPrice;
  String? prodCustomerPrice;
  String? prodInventory;
  String? prodLatestAddInventory;
  String? prodMinDistrubutorQty;
  String? prodMinCustomerQty;
  int? prodAvailable;
  String? prodCategorieId;
  String? prodStatus;
  String? createdById;
  String? adminId;
  String? createdAt;
  String? updatedAt;

  ProductDetails(
      {this.id,
        this.prodName,
        this.prodImage,
        this.prodImageUrl,
        this.prodShortDescription,
        this.prodDescription,
        this.prodDistributorPrice,
        this.prodCustomerPrice,
        this.prodInventory,
        this.prodLatestAddInventory,
        this.prodMinDistrubutorQty,
        this.prodMinCustomerQty,
        this.prodAvailable,
        this.prodCategorieId,
        this.prodStatus,
        this.createdById,
        this.adminId,
        this.createdAt,
        this.updatedAt});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodName = json['prod_name'];
    prodImage = json['prod_image'];
    prodImageUrl = json['prod_image_url'];
    prodShortDescription = json['prod_short_description'];
    prodDescription = json['prod_description'];
    prodDistributorPrice = json['prod_distributor_price'];
    prodCustomerPrice = json['prod_customer_price'];
    prodInventory = json['prod_inventory'];
    prodLatestAddInventory = json['prod_latestAdd_inventory'];
    prodMinDistrubutorQty = json['prod_min_distrubutor_qty'];
    prodMinCustomerQty = json['prod_min_customer_qty'];
    prodAvailable = json['prod_available'];
    prodCategorieId = json['prod_categorie_id'];
    prodStatus = json['prod_status'];
    createdById = json['created_by_id'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['prod_name'] = prodName;
    data['prod_image'] = prodImage;
    data['prod_image_url'] = prodImageUrl;
    data['prod_short_description'] = prodShortDescription;
    data['prod_description'] = prodDescription;
    data['prod_distributor_price'] = prodDistributorPrice;
    data['prod_customer_price'] = prodCustomerPrice;
    data['prod_inventory'] = prodInventory;
    data['prod_latestAdd_inventory'] = prodLatestAddInventory;
    data['prod_min_distrubutor_qty'] = prodMinDistrubutorQty;
    data['prod_min_customer_qty'] = prodMinCustomerQty;
    data['prod_available'] = prodAvailable;
    data['prod_categorie_id'] = prodCategorieId;
    data['prod_status'] = prodStatus;
    data['created_by_id'] = createdById;
    data['admin_id'] = adminId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Productgallery {
  int? id;
  String? galleryImageName;
  String? galleryImageUrl;
  String? productId;
  String? createdAt;
  String? updatedAt;

  Productgallery(
      {this.id,
        this.galleryImageName,
        this.galleryImageUrl,
        this.productId,
        this.createdAt,
        this.updatedAt});

  Productgallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    galleryImageName = json['gallery_image_name'];
    galleryImageUrl = json['gallery_image_url'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['gallery_image_name'] = galleryImageName;
    data['gallery_image_url'] = galleryImageUrl;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

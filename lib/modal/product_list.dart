class ProductListResponse {
  bool? status;
  String? message;
  List<Product>? productList;

  ProductListResponse({this.status, this.message, this.productList});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      productList = <Product>[];
      json['record'].forEach((v) {
        productList!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (productList != null) {
      data['record'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? prodName;
  String? prodImage;
  String? prodImageUrl;
  String? prodVideoUrl;
  String? prodVideo;
  String? prodShortDescription;
  String? prodDescription;
  String? prodDistributorPrice;
  String? prodCustomerPrice;
  String? prodInventoryType;
  String? prodInventory;
  String? availStock;
  String? prodLatestAddInventory;
  String? prodMinDistrubutorQty;
  String? prodMinCustomerQty;
  String? prodAvailable;
  String? prodCategorieId;
  String? prodStatus;
  String? createdById;
  String? adminId;
  String? createdAt;
  String? updatedAt;
  CategoryDetails? categoryDetails;
  List<GalleryImages>? galleryImages;
  List<IsCart>? isCart;

  Product(
      {this.id,
        this.prodName,
        this.prodImage,
        this.prodImageUrl,
        this.prodVideoUrl,
        this.prodVideo,
        this.prodShortDescription,
        this.prodDescription,
        this.prodDistributorPrice,
        this.prodCustomerPrice,
        this.prodInventoryType,
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
        this.updatedAt,
        this.categoryDetails,
        this.galleryImages,
        this.isCart});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodName = json['prod_name'];
    prodImage = json['prod_image'];
    prodImageUrl = json['prod_image_url'];
    prodVideoUrl = json['prod_video_url'];
    prodVideo = json['prod_video'];
    prodShortDescription = json['prod_short_description'];
    prodDescription = json['prod_description'];
    prodDistributorPrice = json['prod_distributor_price'];
    prodCustomerPrice = json['prod_customer_price'];
    prodInventoryType = json['prod_inventory_type'];
    prodInventory = json['prod_inventory'];
    availStock = json['available_stock'];
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
    categoryDetails = json['category_details'] != null
        ? CategoryDetails.fromJson(json['category_details'])
        : null;
    if (json['gallery_images'] != null) {
      galleryImages = <GalleryImages>[];
      json['gallery_images'].forEach((v) {
        galleryImages!.add(GalleryImages.fromJson(v));
      });
    }
    if (json['is_cart'] != null) {
      isCart = <IsCart>[];
      json['is_cart'].forEach((v) {
        isCart!.add(IsCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['prod_name'] = prodName;
    data['prod_image'] = prodImage;
    data['prod_image_url'] = prodImageUrl;
    data['prod_video_url'] = prodVideoUrl;
    data['prod_video'] = prodVideo;
    data['prod_short_description'] = prodShortDescription;
    data['prod_description'] = prodDescription;
    data['prod_distributor_price'] = prodDistributorPrice;
    data['prod_customer_price'] = prodCustomerPrice;
    data['prod_inventory_type'] = prodInventoryType;
    data['prod_inventory'] = prodInventory;
    data['available_stock'] = availStock;
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
    if (categoryDetails != null) {
      data['category_details'] = categoryDetails!.toJson();
    }
    if (galleryImages != null) {
      data['gallery_images'] = galleryImages!.map((v) => v.toJson()).toList();
    }
    if (isCart != null) {
      data['is_cart'] = isCart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  int? id;
  String? catName;

  CategoryDetails({this.id, this.catName});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_name'] = this.catName;
    return data;
  }
}

class GalleryImages {
  int? id;
  String? galleryImageName;
  String? galleryImageUrl;
  String? productId;

  GalleryImages(
      {this.id, this.galleryImageName, this.galleryImageUrl, this.productId});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    galleryImageName = json['gallery_image_name'];
    galleryImageUrl = json['gallery_image_url'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallery_image_name'] = this.galleryImageName;
    data['gallery_image_url'] = this.galleryImageUrl;
    data['product_id'] = this.productId;
    return data;
  }
}

class IsCart {
  int? id;
  int? quantity;
  String? productId;
  String? unitPrice;
  int? amount;

  IsCart({this.id, this.quantity, this.productId});

  IsCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productId = json['product_id'];
    unitPrice = json['unit_price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['quantity'] = quantity;
    data['product_id'] = productId;
    data['unit_price'] = unitPrice;
    data['amount'] = amount;
    return data;
  }
}

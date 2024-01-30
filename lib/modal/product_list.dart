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
        productList!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productList != null) {
      data['record'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
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
        this.updatedAt,
        this.categoryDetails,
        this.galleryImages,
        this.isCart});

  Product.fromJson(Map<String, dynamic> json) {
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
    categoryDetails = json['category_details'] != null
        ? new CategoryDetails.fromJson(json['category_details'])
        : null;
    if (json['gallery_images'] != null) {
      galleryImages = <GalleryImages>[];
      json['gallery_images'].forEach((v) {
        galleryImages!.add(new GalleryImages.fromJson(v));
      });
    }
    if (json['is_cart'] != null) {
      isCart = <IsCart>[];
      json['is_cart'].forEach((v) {
        isCart!.add(new IsCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prod_name'] = this.prodName;
    data['prod_image'] = this.prodImage;
    data['prod_image_url'] = this.prodImageUrl;
    data['prod_short_description'] = this.prodShortDescription;
    data['prod_description'] = this.prodDescription;
    data['prod_distributor_price'] = this.prodDistributorPrice;
    data['prod_customer_price'] = this.prodCustomerPrice;
    data['prod_inventory'] = this.prodInventory;
    data['prod_latestAdd_inventory'] = this.prodLatestAddInventory;
    data['prod_min_distrubutor_qty'] = this.prodMinDistrubutorQty;
    data['prod_min_customer_qty'] = this.prodMinCustomerQty;
    data['prod_available'] = this.prodAvailable;
    data['prod_categorie_id'] = this.prodCategorieId;
    data['prod_status'] = this.prodStatus;
    data['created_by_id'] = this.createdById;
    data['admin_id'] = this.adminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.categoryDetails != null) {
      data['category_details'] = this.categoryDetails!.toJson();
    }
    if (this.galleryImages != null) {
      data['gallery_images'] =
          this.galleryImages!.map((v) => v.toJson()).toList();
    }
    if (this.isCart != null) {
      data['is_cart'] = this.isCart!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? quantity;
  String? productId;

  IsCart({this.id, this.quantity, this.productId});

  IsCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    return data;
  }
}

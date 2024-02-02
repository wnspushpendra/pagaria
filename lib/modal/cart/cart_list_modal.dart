class CartProductResponseModal {
  bool? status;
  String? message;
  List<CartItem>? cartItem;
  String? productAmount;

  CartProductResponseModal(
      {this.status, this.message, this.cartItem, this.productAmount});

  CartProductResponseModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      cartItem = <CartItem>[];
      json['record'].forEach((v) {
        cartItem!.add(new CartItem.fromJson(v));
      });
    }
    productAmount = json['productAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cartItem != null) {
      data['record'] = this.cartItem!.map((v) => v.toJson()).toList();
    }
    data['productAmount'] = this.productAmount;
    return data;
  }
}

class CartItem {
  int? id;
  String? productId;
  String? quantity;
  int? amount;
  String? unitPrice;
  String? userType;
  String? cartUserId;
  String? createdAt;
  String? updatedAt;
  ProductDetails? productDetails;

  CartItem(
      {this.id,
        this.productId,
        this.quantity,
        this.amount,
        this.unitPrice,
        this.userType,
        this.cartUserId,
        this.createdAt,
        this.updatedAt,
        this.productDetails});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    unitPrice = json['unit_price'];
    userType = json['user_type'];
    cartUserId = json['cart_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['unit_price'] = this.unitPrice;
    data['user_type'] = this.userType;
    data['cart_user_id'] = this.cartUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
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
  String? prodAvailable;
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
    return data;
  }
}

import 'package:webnsoft_solution/modal/product_list.dart';

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
        cartItem!.add(CartItem.fromJson(v));
      });
    }
    productAmount = json['productAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (cartItem != null) {
      data['record'] = cartItem!.map((v) => v.toJson()).toList();
    }
    data['productAmount'] = productAmount;
    return data;
  }
}

class CartItem {
  int? id;
  String? productId;
  int? quantity;
  int? amount;
  String? unitPrice;
  String? userType;
  String? cartUserId;
  String? createdAt;
  String? updatedAt;
  Product? productDetails;

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
        ? Product.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['unit_price'] = unitPrice;
    data['user_type'] = userType;
    data['cart_user_id'] = cartUserId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
    }
    return data;
  }
}

/*class ProductDetails {
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
}*/

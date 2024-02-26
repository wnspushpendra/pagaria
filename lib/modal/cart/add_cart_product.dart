class AddProductCartResponse {
  bool? status;
  String? message;
  CartProduct? cartProduct;

  AddProductCartResponse({this.status, this.message, this.cartProduct});

  AddProductCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartProduct =
    json['record'] != null ? CartProduct.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (cartProduct != null) {
      data['record'] = cartProduct!.toJson();
    }
    return data;
  }
}

class CartProduct {
  String? productId;
  String? userType;
  String? cartUserId;
  int? quantity;
  int? amount;
  String? updatedAt;
  String? createdAt;
  int? id;

  CartProduct(
      {this.productId,
        this.userType,
        this.cartUserId,
        this.quantity,
        this.amount,
        this.updatedAt,
        this.createdAt,
        this.id});

  CartProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    userType = json['user_type'];
    cartUserId = json['cart_user_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['user_type'] = userType;
    data['cart_user_id'] = cartUserId;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

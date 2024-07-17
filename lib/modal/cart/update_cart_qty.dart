import 'package:webnsoft_solution/modal/cart/cart_list_modal.dart';

class UpdateCartQuantityResponseModal {
  bool? status;
  String? message;
  CartItem? updateCartItem;
  String? cartTotal;
  //UpdateCartItem? updateCartItem;

  UpdateCartQuantityResponseModal({this.status, this.message, this.updateCartItem,this.cartTotal});

  UpdateCartQuantityResponseModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    updateCartItem = json['record'] != null ? CartItem.fromJson(json['record']) : null;
    cartTotal = json['productAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (updateCartItem != null) {
      data['record'] = updateCartItem!.toJson();
    }
    data['productAmount'] = cartTotal ;

    return data;
  }
}

class UpdateCartItem {
  int? id;
  String? productId;
  String? quantity;
  int? amount;
  String? userType;
  String? cartUserId;
  String? createdAt;
  String? updatedAt;

  UpdateCartItem(
      {this.id,
        this.productId,
        this.quantity,
        this.amount,
        this.userType,
        this.cartUserId,
        this.createdAt,
        this.updatedAt});

  UpdateCartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    userType = json['user_type'];
    cartUserId = json['cart_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['user_type'] = userType;
    data['cart_user_id'] = cartUserId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

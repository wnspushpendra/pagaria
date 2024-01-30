class RemoveCartItemModal {
  bool? status;
  String? message;
  String? cartItemId;

  RemoveCartItemModal({this.status, this.message, this.cartItemId});

  RemoveCartItemModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartItemId = json['cart_item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['cart_item_id'] = cartItemId;
    return data;
  }
}

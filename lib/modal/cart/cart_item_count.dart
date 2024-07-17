class CartCountModal {
  bool? status;
  String? message;
  int? cartItemCount;

  CartCountModal({this.status, this.message, this.cartItemCount});

  CartCountModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartItemCount = json['cartItemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['cartItemCount'] = cartItemCount;
    return data;
  }
}

class OrderProduct {
  int? amount;
  int? quantity;
  String? prodName;
  String? userType;
  String? prodImage;
  String? productId;
  String? prodImageUrl;
  String? prodShortDescription;

  OrderProduct(
      {this.amount,
        this.quantity,
        this.prodName,
        this.userType,
        this.prodImage,
        this.productId,
        this.prodImageUrl,
        this.prodShortDescription});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    quantity = json['quantity'];
    prodName = json['prod_name'];
    userType = json['user_type'];
    prodImage = json['prod_image'];
    productId = json['product_id'];
    prodImageUrl = json['prod_image_url'];
    prodShortDescription = json['prod_short_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['quantity'] = quantity;
    data['prod_name'] = prodName;
    data['user_type'] = userType;
    data['prod_image'] = prodImage;
    data['product_id'] = productId;
    data['prod_image_url'] = prodImageUrl;
    data['prod_short_description'] = prodShortDescription;
    return data;
  }
}

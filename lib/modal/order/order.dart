class OrderResponse {
  bool? status;
  String? message;
  OrderDetail? orderDetail;

  OrderResponse({this.status, this.message, this.orderDetail});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail =
    json['record'] != null ? OrderDetail.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['record'] = orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  String? totalAmount;
  String? userType;
  String? userId;
  String? bookedById;
  String? allProduct;
  String? adminId;
  String? updatedAt;
  String? createdAt;
  int? id;

  OrderDetail(
      {this.totalAmount,
        this.userType,
        this.userId,
        this.bookedById,
        this.allProduct,
        this.adminId,
        this.updatedAt,
        this.createdAt,
        this.id});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    userType = json['user_type'];
    userId = json['user_id'];
    bookedById = json['booked_by_id'];
    allProduct = json['allProduct'];
    adminId = json['admin_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['booked_by_id'] = bookedById;
    data['allProduct'] = allProduct;
    data['admin_id'] = adminId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
